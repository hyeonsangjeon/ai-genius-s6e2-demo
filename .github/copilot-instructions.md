# Repository context and working agreements

## Start here

Read `PLAYBOOK.md` before changing this repository. It is the single source for
the planned presentation flow, reusable setup and commands. This is the public independent
`hyeonsangjeon/ai-genius-s6e2-demo` repository; read `UPSTREAM.md` for source attribution.
Keep new run history, raw scores, cloud resource IDs and machine-specific handoffs in ignored
local storage. Committed baselines are attributed upstream references, not local measurements.
These instructions guide coding assistants; the hosted agent's instructions
are in `sample/agent/.agent_configs/baseline/instructions.md`.

This is a presentation and deliberately small demonstration, not a production
agent framework. The six-demo story is **model comparison -> grounded agent -> trace ->
evaluation -> optimisation -> CI/CD quality gates**. Keep the audience focused on those concepts.
The user's priority is simplicity: avoid scaffolding, abstractions, helper
layers and documentation that obscure the sample.

## Layout

- Source presentation references, including the original deck, are local only in ignored
  `_local/references/graeme-source/presentation/`; working PPT copies belong in `_local/ppt/`.
  Do not restore HTML slides, artwork or rehearsal-coach files to tracked source.
- `sample/agent/`: the deployable Python agent, baseline configuration and
  fictional policy/notice documents.
- `sample/evaluation/`: `evaluate.py`, `compare_to_baseline.py`, `optimize.yaml`,
  two judge definitions, committed baselines and the development, holdout and
  drift JSONL datasets.
- `.github/workflows/`: PR gate (development set) and promotion (holdout, then
  drift, then release), sharing `_agent-eval.yml`.
- `sample/azure.yaml`, dependency manifests and lock files: runnable sample
  configuration. Run backstage commands from `sample/`.
- `sample/infra/modules/monitoring.bicep`: companion deployment for Application Insights,
  its project connection and account-level Foundry User access for the evaluator.
- `PLAYBOOK.md`: presenter/operator guide. Its upstream 25-slide mapping needs adjustment
  to 50 minutes plus 10 minutes Q&A; it is not the final Korean deck. Keep presentation
  reviews, notes and execution plans in the ignored local vault.
- `UPSTREAM.md`: imported revision, attribution and cleanup scope.

Do not restore the removed `src/`, test suite, historical datasets, slide-review
screenshots or template/conversion files unless requested. Generated
`sample/evidence/` remains ignored; the demo script does not generate evidence files.

## Current state

This preparation repository has not been deployed or evaluated in its own environment.
Cloud deployment, live demos, evaluation, optimisation and workflow execution are paused.
Repository cleanup, documentation or push does not authorise those actions.

- Baseline and `evaluation/candidates/reviewed/` currently have identical instructions,
  metadata and tools. Do not present that pair as an improvement or invent a score gain.
- Baseline `source` metadata identifies upstream measurements; evaluation/run IDs and
  private portal links were removed. Preserve provenance when copying or replacing them.
  New fingerprints cannot turn old scores into new measurements.
- Model comparison and measured quality/latency/token/cost comparison remain preparation
  gaps. Trace timings and tokens do not establish quality or total platform cost.
- Repository Actions are disabled. Cloud jobs also require repository variable
  `ENABLE_CLOUD_DEMOS` to equal `true`; leave it unset or false until execution resumes.

## Agent design

- Native Microsoft Agent Framework with `FoundryChatClient` and
  `ResponsesHostServer`. Hosting and Agent Framework own tracing and the
  model/tool loop. Do not reintroduce custom spans or orchestration.
- Three read-only tools over local JSON stand in for the IQ tools:
  `knowledge_base_retrieve` (Foundry IQ; hybrid keyword plus embedding search over
  policies), `ask` (Work IQ; roles, leave, delegations) and `search_ontology`
  (Fabric IQ; budget). **No real Foundry, Work or Fabric IQ is connected.**
- The agent advises on purchasing; it cannot approve, buy or contact approvers.
- Keep mutable policy facts in retrieved documents, not system instructions or
  tool descriptions. Preserve native optimiser configuration loading.
- Use the decision date supplied in the question. Ask if it is needed and
  missing. Do not inject today's date or restore a fixed sample/reference date.
  Policy effective dates come from retrieved documents.

## Evaluation and optimisation

The objective is **next best action**, not always next best question:
ask for missing decision facts, identify outstanding requirements, or recognise
readiness. Do not list alternative routes before resolving missing facts or
reopen approvals already supplied as complete.

- The binary `purchasing-next-action` judge is shared by evaluation and
  optimisation; `purchasing-demo-rubric` adds feedback dimensions. Do not
  silently change a rubric to improve a score.
- Only the question goes to the agent. The next-action judge receives the question,
  `ground_truth`, answer and tool calls; the rubric receives the question and answer.
  The optimiser service receives references;
  its exact internal reflector inputs have not been established.
- `evaluate.py` registers the judges (`--register-only`), submits an evaluation
  (`EVAL_DATASET` selects the set; `--dry-run` prints the request) and writes the
  report that `compare_to_baseline.py` gates. Optimisation uses the static baseline,
  separate datasets and registered judge version in `evaluation/optimize.yaml`.
  Dataset paths resolve from the service's `sample/agent/` directory, not the YAML.
- **`azd ai agent optimize` submits optimisation jobs.** Python is not a
  replacement optimisation engine. Submit `evaluation/optimize.yaml` directly;
  no Python preparation or copied input package is needed.
- Preserve separate development and native `validation_dataset` inputs.
  Validation influences candidate selection; it is not untouched acceptance.
- Inspect effective system instructions **and tool/parameter descriptions**.
  A mutation record alone may omit inherited candidate configuration.
- The CLI can rewrite baseline `metadata.yaml` to reference frozen tools.
  Preserve evidence, compare tool bytes, then restore only the unintended path.
  The local baseline normally uses `tools_file: tools.json`.

CLI evaluation is possible. This import retains the upstream Python workflow. `azd ai agent eval` and the separate `azd ai eval` extension
have different configurations; do not conflate them or claim golden-data
evaluation is unsupported. Do not restart that migration without a request.

## Demo conventions

- The configured agent name is `purchasing-advice-demo`. Select the actual project,
  subscription and region when deployment is authorised; source examples are not selections.
- Check actual returned agent/judge versions and align the script/YAML; do not infer live
  state or version numbers from documentation.
- The agent uses GPT-5.4-mini with low reasoning; judge/generator use GPT-5.5.
- The corpus contains 22 policies and five notices; datasets contain 34 development,
  22 holdout and 8 drift cases. All questions supply an explicit decision date.
- Gates compare with baselines committed by a person; a pipeline never writes
  its own bar. Never give the drift set to the optimiser.
- The companion Bicep provides monitoring and account-level Foundry User access.
  Project-only or OpenAI-only access is insufficient for cloud judging.
- Continuous evaluation is a setup walkthrough. Do not enable it or promote a
  candidate as part of routine demo preparation.

## Change and execution discipline

Work within the user’s authorised scope and preserve unrelated edits. Do not commit or push
unless asked. Use `hyeonsangjeon` for authorised GitHub commits/pushes; do not put "Codex" in
PR titles or bodies. Keep comments and documentation concise.

Do not run billable evaluations/searches, deploy, promote candidates, provision,
delete resources or change RBAC/networking without explicit approval. Discover
project/environment details from local azd state. An authorised app-only
deployment uses `azd deploy purchasing-advice-demo`, not `azd up`.

Bind GitHub commands explicitly with `--repo hyeonsangjeon/ai-genius-s6e2-demo`. Before later
provisioning, verify the selected azd environment's `GITHUB_REPOSITORY`: preprovision reuses
its saved value before considering origin. Postprovision writes GitHub environments/variables;
postdeploy grants embedding access. These hooks are not part of clone, cleanup or push and
must remain unexecuted while cloud work is paused.

Use Python 3.13 and the existing locked dependencies (`requirements*.txt`,
exported from `uv.lock`). With Actions enabled, PRs run offline checks. Billable development
evaluation and main promotion additionally require repository-level
`ENABLE_CLOUD_DEMOS == 'true'`. Preserve gates on promotion `target`/`release`, PR
`development` and reusable `evaluate`. Do not enable the flag or dispatch workflows as a
side effect of repository preparation. Offline checks, from `sample/`:

```bash
.venv/bin/ruff check agent evaluation
.venv/bin/ruff format --check agent evaluation
.venv/bin/python evaluation/evaluate.py --dry-run
```

The dry run prints the request without writing files or making cloud calls. Check actual input
mapping, dataset separation and file paths when editing the evaluation helper.
Do not recreate a test framework as part of routine cleanup.

Use the package index approved for the current environment.
Do not casually upgrade agent dependencies or azd extensions during a demo task.
Never check in credentials, environment secrets or unreviewed raw telemetry.
