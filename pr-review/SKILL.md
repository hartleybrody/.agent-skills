---
name: pr-review
description: Begin a review for a set of changes in a PR
---

can you please look through the changes on this PR's branch, compared to the target branch for the PR? if not target is specified, then compare to `main` branch

then please provide
- a high level overview of the changes (3-5 sentences)
- a breakdown of how much of it is application code, tests, mock data or whitespace changes

afterwards, provide a summary of
- any new patterns or deviations from existing patterns
- any code that doesn't seem to have test coverage
- code comments that suppress linter or formatter rules
- anywhere there are security or performance concerns

