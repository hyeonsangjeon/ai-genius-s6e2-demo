# AI Genius Season 6 Episode 2

Hyeonsang Jeon's working repository for **AI 워크플로 품질 측정, 벤치마킹 및 개선**:
model choice, organizational context, traces, evaluation, optimization, and CI/CD
with Microsoft Foundry.

This is an independent snapshot of Graeme Foster's sample, imported on 2026-10-27.
See [UPSTREAM.md](UPSTREAM.md) for the original source and changes made during import.

## Current state

Source preparation is in progress. This repository has **not yet been deployed or
validated in Hyeonsang's Azure environment**. The included baseline scores are
upstream reference results, not measurements from this repository.

The purchasing agent uses three read-only tools over fictional local data. They
stand in for Foundry IQ, Work IQ, and Fabric IQ; they do not connect to those services.

Cloud workflow jobs are disabled by default. They require the repository variable
`ENABLE_CLOUD_DEMOS` to equal `true`, plus the Azure and GitHub configuration in the
playbook. The variable is not enabled during repository setup.

## Contents

| Path | Purpose |
| --- | --- |
| `sample/agent/` | Purchasing advice agent, prompts, tools, and fictional data |
| `sample/evaluation/` | Datasets, judges, optimizer configuration, comparison scripts, and reference baselines |
| `sample/infra/` | Foundry infrastructure and setup hooks |
| `.github/workflows/` | Offline PR checks and opt-in cloud evaluation/release workflows |
| [PLAYBOOK.md](PLAYBOOK.md) | Demo sequence, prerequisites, known gaps, and later execution steps |

Working slides, review notes, execution records, and original presentation assets
are kept in the gitignored `_local/` folder on the preparation machine. They are
not included in a clone of this repository.

## Start with review

Read the playbook before running commands. Python 3.13 and the checked-in dependency
locks are required. Deployment, model calls, evaluation, and optimization have not
been resumed; importing the source does not configure Azure.

Known preparation gaps include a separate model/cost comparison, an initial prompt
state for the improvement PR demo, and verification of the agent's hybrid search
and trace in the target environment. See the playbook for the acceptance criteria.

- [Hyeonsang's Korean session](https://developer.microsoft.com/en-us/reactor/events/27625/)
- [Graeme's English session](https://reactor.microsoft.com/en-us/reactor/events/27640/)
