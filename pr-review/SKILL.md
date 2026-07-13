---
name: pr-review
description: Begin a review for a set of changes in a PR
---

Please review the changes on the current git branch compared to the PR target branch, or `main` if the target is unavailable.

I am specifically looking for opportunities to tighten up the code logic and keep the PR small and conceptually clean. Focus on:
- redundant calculations or duplicated work
- leaky abstractions across layers
- duplicated conditionals or state-machine logic
- places where adding or clarifying an invariant would simplify the code
- code that could move to an existing helper/model/service to reduce PR surface area
- areas where tests mirror duplicated implementation rather than asserting the intended invariant

Please do not run linters or unit tests unless needed to understand behavior. CI already covers deterministic checks.

Output format:
1. PR Overview: 3-5 sentences summarizing what changed.
2. Findings: a quick list of actionable findings, each 2-3 sentences, ordered by impact. Include file/line references where possible.
3. Tightening Opportunities: optional short list of low-risk cleanup ideas if they are not serious enough to be findings.
