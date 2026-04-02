---
name: pr-create
description: Create a new Pull Request (PR)
---

can you please create a PR for this current branch?

  - please push this branch to github ("origin")
  - please set the target branch of the PR to be whatever this branch was branched off from
    - if this branch was directly off of `main` or `master` it’s okay to use default target branch
    - it this branch was "stacked" on top of another branch, use that other branch as the target for the PR
  - please look for a PR template file, usually found at @.github/pull_request_template.md
    - leave any sections about summary, tickets or links to discussions as-is, i’ll fill those out
    - fill out each other section with a few bullet points to summarize
    - remove any prompt text under the headings within each section
  - if there is no pull request template, then just summarize our converastion in a few sentences
    - summary should focus primarily on the goals and intention from my original message or listed in the spec doc

once the PR is created, can you add a comment to the PR to show the entire plan doc in a collapsible section, using the following syntax

```
<details>
<summary>plan doc used to generate these changes</summary>

{ENTIRE CONTENTS OF MARKDOWN PLAN DOC, ENTIRELY COPIED AS-IS, FROM CHAT HISTORY}

</details>
```

finally, can you respond with a message in the format of:

{URL TO PR}
 - lines of code: +{ADDED}, -{REMOVED}, {NUM_COMMITS} commits

