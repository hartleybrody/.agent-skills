---
name: pr-merge-cleanup
description: Verify that the local branch was up-to-date with what got merged in a PR, before deleting the local branch.
---

this feature branch has been merged on origin (github) via pull request.

i would now like to confirm that there are no lingering local edits that i forgot to push, and ensure that the feature branch has no diffs from the latest, post-merge `main` before deleting the local copy of the branch.

## check current branch status

first echo out the name of the current branch, so i know what context you're working with. then, on the current feature branch, run the following:


```bash
git status
```
if there are ANY staged but uncommitted files, exit immediately.

if there are unstaged changes to tracked files, simply warn but continue

do not bother to warn about changes to untracked files.

then pull the latest `main` code into this branch using

```bash
git pull origin main
```

## get the latest `main` branch code

now let's check out the `main` branch and get the latest code there, after the PR was merged:

```bash
git checkout main
git pull origin main
```

## diff the latest `main` against my feature branch

while still running on `main` branch, run

```bash
git diff {feature_branch_name}
```

ensure that output is null/empty

if there is ANY diffs at all between them, exit immediately but log out the delete command below so that i can run it manually if i decide to.

if there are no deltas between the main and feature branch, then run

```bash
git branch -D {feature_branch_name}
```
