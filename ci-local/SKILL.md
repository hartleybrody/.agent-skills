---
name: ci-local
description: Run all CI tests locally, push on success
---

please run all linters and code formatters and ensure those produce no errors. then, run all relevant tests. flag any tests that aren’t passing and summarize the potential reasons for failure.

if all of the linters, formatters and test pass, then please run `git push origin @` for this branch to kick off an actual CI run. do NOT make any additional commits for any uncommitted files.
