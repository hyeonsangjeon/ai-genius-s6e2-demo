# Baselines

These three reports were measured in Hyeonsang's Microsoft Foundry project on
2026-10-28 by running the original purchasing agent (commit `452914f`; results
recorded in `6a42068`). They replace the reference reports imported from Graeme
Foster's sample.

| Set | Next action | Behaviour |
| --- | --- | --- |
| Development | 32/34 | 0.827 |
| Holdout | 18/22 | 0.832 |
| Drift | 8/8 | 0.860 |

Each report keeps its evaluation and run IDs, evaluator versions, dataset hash and
judge provenance. The Foundry portal links (`report_url`) were removed from these
files on 2026-11-23 because they encode the Azure subscription and resource names;
no code reads them. `ci_report.py` still writes `report_url` into new reports, so
delete it before committing a replacement baseline. CI compares a candidate with
these reports only when the dataset, judges and scoring conditions match.

If questions, references, judges, or scoring conditions change, measure and explicitly
review a replacement baseline. Never attach new input hashes to old scores.
