---
name: pr-create
description: Create a new Pull Request (PR)
---

can you please create a PR for this current branch?

  - please push this branch to github ("origin")
  - please set the target branch of the PR to be whatever this branch was branched off from
      - if this branch was directly off of `main` it’s okay to use default target branch
      - it this branch was "stacked" on top of another branch, use that other branch as the target for the PR
  - please look for a PR template file, usually found at @.github/pull_request_template.md
      - leave any sections about summary, tickets or links to discussions as-is, i’ll fill those out
      - fill out each other section with a few bullet points to summarize
      - remove any prompt text under the headings within each section

can you respond with a message in the format of:

{URL TO PR}
 - lines of code: +{ADDED}, -{REMOVED}, {NUM_COMMITS} commits

