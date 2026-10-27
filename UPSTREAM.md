# Upstream source

This repository starts from Graeme Foster's **FoundryEvalsAndObservability** sample
for AI Genius Season 6 Episode 2.

- Author: Graeme Foster
- Source: https://github.com/graemefoster/FoundryEvalsAndObservability
- Imported revision: `8e0519fba7de6aa87d0ee186bd436b601f5220ef`
- Source commit date: 2026-10-19
- Snapshot/import date: 2026-10-27
- Maintainer of this independent preparation repository: Hyeonsang Jeon

The source provides the agent, fictional data, evaluation datasets and judges,
optimizer configuration, infrastructure, and CI/CD sample. Their authorship is
preserved by this attribution. This is an independent repository, not a GitHub fork.

## Import changes

- Started a new Git history from the reviewed snapshot. The original history is
  retained locally for reference, not republished as this repository's history.
- Kept PowerPoint files, HTML slides, event artwork, and the rehearsal coach in the
  ignored local reference folder. They are outside this source repository.
- Removed upstream evaluation/run IDs and private portal report links from the
  three reference baseline files. Scores, dataset hashes, and judge provenance
  remain unchanged; each file records its original source and removed fields.
- Added default-off repository-variable gates to cloud workflow jobs.
- Updated repository guidance and excluded local drafts, credentials, and caches.

Agent behavior, fictional policies, evaluation criteria, data splits, model
configuration, and dependency locks were not changed during the import.

## Baseline attribution

The files under `sample/evaluation/baselines/` contain upstream reference scores.
They do not demonstrate a deployment or evaluation in this repository's environment.
Keep their `source` metadata when copying them. Changes to datasets or judges require
new baseline measurements, not new hashes attached to old scores.

## Reuse and updates

No license file was present at the imported revision. This import does not assert
a new license or grant additional redistribution rights. Preserve source attribution
when reviewing reuse or publication.

Review upstream changes selectively. Compare the source revision, inspect changes
to code/data/judges/decks, and record what is adopted. Do not use an automatic mirror
to overwrite local adaptations. There is no scheduled synchronization job.
