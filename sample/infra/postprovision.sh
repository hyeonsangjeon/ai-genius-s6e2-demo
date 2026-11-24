#!/bin/sh
# postprovision hook (see azure.yaml). Provisioning (main.bicep) created the GitHub Actions
# identity; this points GitHub at it: if the GitHub CLI is signed in, create the `demo`
# environment in GITHUB_REPOSITORY and set its seven secrets. Never fails the provision.
# Re-run on its own (for example after `gh auth login`): azd hooks run postprovision
set -u
# azd prints "key not found" on stdout, so only use its output when it succeeds.
v() { out="$(azd env get-value "$1" 2>/dev/null)" && printf '%s' "$out"; }
REPO="$(v GITHUB_REPOSITORY)"
CLIENT_ID="$(v githubClientId)"  # camelCase: see the outputs in main.bicep
if [ -z "$REPO" ] || [ -z "$CLIENT_ID" ]; then
  echo "WARNING: GITHUB_REPOSITORY or githubClientId missing; was main.bicep provisioned?" >&2
  exit 0
fi
if ! command -v gh >/dev/null 2>&1 || ! gh auth status >/dev/null 2>&1; then
  echo "WARNING: GitHub CLI not signed in. After 'gh auth login', run: azd hooks run postprovision" >&2
  exit 0
fi
if ! gh api -X PUT "repos/$REPO/environments/demo" --silent; then
  echo "WARNING: couldn't create the 'demo' environment in $REPO (are you an admin?)." >&2
  exit 0
fi
set_secret() {
  if [ -z "$2" ]; then
    echo "WARNING: no value for demo secret $1." >&2
    return 1
  fi
  if ! printf '%s' "$2" | gh secret set "$1" --env demo --repo "$REPO" >/dev/null 2>&1; then
    echo "WARNING: couldn't set demo secret $1." >&2
    return 1
  fi
}

secrets_ready=true
set_secret AZURE_CLIENT_ID "$CLIENT_ID" || secrets_ready=false
set_secret AZURE_TENANT_ID "$(v githubTenantId)" || secrets_ready=false
for key in AZURE_SUBSCRIPTION_ID AZURE_ENV_NAME AZURE_LOCATION AZURE_AI_PROJECT_ID \
  FOUNDRY_PROJECT_ENDPOINT; do
  set_secret "$key" "$(v "$key")" || secrets_ready=false
done
if [ "$secrets_ready" = true ]; then
  echo "Set all seven GitHub secrets for the 'demo' environment in $REPO."
else
  echo "WARNING: 'demo' environment secrets are incomplete. Rerun the hook after correcting the warnings." >&2
fi

# `production`: the release workflow's approval step. It never signs in to Azure; it only
# waits for a required reviewer, here whoever is signed in to `gh`.
ME="$(gh api user --jq .id 2>/dev/null || true)"
if [ -n "$ME" ] && printf '{"reviewers":[{"type":"User","id":%s}]}' "$ME" \
  | gh api -X PUT "repos/$REPO/environments/production" --input - --silent; then
  echo "GitHub environment 'production' in $REPO requires your approval for releases."
else
  echo "WARNING: couldn't create 'production' with you as reviewer (required reviewers need a public repo or a paid plan). Create it in the repo's Settings > Environments." >&2
fi
