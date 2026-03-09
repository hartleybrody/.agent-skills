---
name: plan-implement
description: Begin implementing from a plan doc
---

please read this plan doc and get started on implementation. if no plan document is provided in the message, please stop immediately and prompt for the file path, do NOT guess.

update the planning doc to mark off each section as you complete it, and add any notes or issues you ran into during implementation of that section.

ensure that all code linters and formatters pass, and that you're following conventions in @AGENTS.md and other coding agent rules. please implement the tests described in the plan, but do NOT worry about tests passing yet, i'll review those later.

please create a new branch with an initially empty marker commit (to help with resolving stacked branches), but do NOT commit any changes yet:

```
git switch -c hartley/{FEATURE_NAME} && git commit --allow-empty -m "START stacked branch"
```

please add a summary of the completed implementation to the bottom of the doc.
