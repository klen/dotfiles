---
name: review-finish
---

Commit and push the current changes, then wait for all required PR checks to
pass. Approve the PR if permitted, and merge it once all merge requirements are
satisfied. Do not bypass required checks or branch protection rules.

After a successful merge:

Move the linked task to Testing, if one exists.

Switch to develop and update it from the remote using a fast-forward pull.

Delete the local feature branch if it exists and is no longer checked out.
Preserve any unrelated uncommitted changes.

## Report

Short, plain sentences. If there was a linked task, lead with it:

- **Task:** link, its new status, and the merged **PR** link if there is one.
- **What changed:** what the change does now, user-visible, not a file list.
- **How to verify:** the shortest path — command, URL, or steps — and what
  the reviewer should see.
- **Still open:** anything unresolved, deferred, or untested, each with why.
  Say "None." when there is nothing.

No linked task: same three sections, without the task line.

Close with whether local cleanup and the develop update succeeded. If any step
is blocked, explain why and what is needed to proceed.
