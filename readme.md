# AI Genius Season 6 Episode 2

Demo repository for Hyeonsang Jeon's session **AI 워크플로 품질 측정, 벤치마킹 및 개선**:
model choice, organizational context, traces, evaluation, optimization, and CI/CD
with Microsoft Foundry.

This is an independent copy of Graeme Foster's sample, imported on 2026-10-27.
See [UPSTREAM.md](UPSTREAM.md) for the original source and changes made during import.
The documents shown at the end of the session are listed in [REFERENCES.md](REFERENCES.md).

## Current state

The agent runs in Hyeonsang's Microsoft Foundry project, and the six demos in the
Korean session were recorded from this repository.

- The baselines in `sample/evaluation/baselines/` were measured in this project on
  2026-10-28 with the original agent: next action 32/34 on development, 18/22 on
  holdout and 8/8 on drift.
- The reviewed optimizer candidate, with the copied facts removed, went through the
  PR gate and was merged in [#3](https://github.com/hyeonsangjeon/ai-genius-s6e2-demo/pull/3).

The purchasing agent uses three read-only tools over fictional local data. They
stand in for Foundry IQ, Work IQ, and Fabric IQ; they do not connect to those services.

Cloud workflow jobs run only when the repository variable `ENABLE_CLOUD_DEMOS` is
`true` and the Azure and GitHub configuration in the playbook is in place.

## Contents

| Path | Purpose |
| --- | --- |
| `sample/agent/` | Purchasing advice agent, prompts, tools, and fictional data |
| `sample/evaluation/` | Datasets, judges, optimizer configuration, comparison scripts, and measured baselines |
| `sample/infra/` | Foundry infrastructure and setup hooks |
| `.github/workflows/` | Offline PR checks and opt-in cloud evaluation/release workflows |
| [PLAYBOOK.md](PLAYBOOK.md) | Demo sequence, prerequisites, and setup steps |

Slides, review notes and recordings stay in the gitignored `_local/` folder and are
not part of a clone.

## Getting started

Read the playbook before running commands. Python 3.13 and the checked-in dependency
locks are required, and cloning the repository does not configure Azure.

- [Hyeonsang's Korean session](https://developer.microsoft.com/en-us/reactor/events/27625/)
- [Graeme's English session](https://reactor.microsoft.com/en-us/reactor/events/27640/)
