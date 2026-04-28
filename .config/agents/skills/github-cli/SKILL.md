---
name: github-cli
description: Use the `gh` CLI for all GitHub interactions — issues, PRs, discussions, releases, repos, Actions, and API calls. Prefer `gh` over direct web browsing, web search, or raw git/HTTPS API calls whenever the target is on GitHub. Avoid cloning repos to read files; use `gh api` or `gh repo view` instead.
---

# GitHub CLI (`gh`)

The `gh` CLI is the preferred way to interact with GitHub from this environment.
It handles authentication, pagination, JSON output, and API discovery automatically.
**Always use `gh` instead of opening GitHub URLs in a browser, using `curl` against the REST/GraphQL API, or cloning
repos just to read files.**

## General Principles

1. **Prefer `gh` over web tools** — When the information lives on GitHub
    (issues, PRs, discussions, repos, releases, Actions, etc.),
    use `gh` commands rather than `web_search` or `web_extract`.
2. **Avoid cloning for reading** — Use `gh api`, `gh repo view`,
    or `gh browse` to inspect remote files and metadata without a local clone.
    Only clone when you need to build, test, or modify code.
3. **Use `--json` and `jq`** — Structured output is easier to parse than human-readable text.
    Pipe through `jq` for filtering.
4. **Paginate with `--limit` or `--jq`** — `gh` auto-paginates; use `--limit` to cap results.

## Repository Operations

### View repo info & files without cloning

```bash
# Repo metadata
gh repo view owner/repo --json name,description,defaultBranchRef,url

# List directory contents (use the default branch)
gh api repos/owner/repo/contents/path/to/dir --jq '.[].name'

# Read a single file (base64-encoded by default)
gh api repos/owner/repo/contents/path/to/file --jq '.content' | base64 -d

# Read a file in a specific branch/tag
gh api "repos/owner/repo/contents/README.md?ref=main" --jq '.content' | base64 -d
```

### Clone only when necessary

```bash
# Shallow clone (faster, less disk)
gh repo clone owner/repo -- --depth=1

# Clone a specific branch
gh repo clone owner/repo -- --branch=develop --single-branch
```

## Issues

```bash
# List open issues
gh issue list -R owner/repo --state open --limit 20

# View an issue with comments
gh issue view 123 -R owner/repo --comments

# Create an issue
gh issue create -R owner/repo --title "Bug: something broke" --body "Details here"

# Search issues across repos
gh search issues "keyword" --owner owner --limit 10

# List issues as JSON
gh issue list -R owner/repo --state open --json number,title,labels,assignees
```

## Pull Requests

```bash
# List PRs
gh pr list -R owner/repo --state open --limit 20

# View a PR with full conversation, reviews, and comments
gh pr view 456 -R owner/repo --comments

# Get the diff of a PR
gh pr diff 456 -R owner/repo

# Checkout a PR locally (creates a local branch)
gh pr checkout 456 -R owner/repo

# Create a PR
gh pr create -R owner/repo --title "feat: new thing" --body "Description" --base main

# Review a PR (approve, request changes, comment)
gh pr review 456 -R owner/repo --approve --body "LGTM"
gh pr review 456 -R owner/repo --request-changes --body "Please fix X"

# Merge a PR
gh pr merge 456 -R owner/repo --squash --delete-branch
```

## Discussions

```bash
# List discussions (GraphQL-based)
gh api graphql -f query='
  query {
    repository(owner:"owner", name:"repo") {
      discussions(first:10) {
        nodes { number title url }
      }
    }
  }
'

# View a specific discussion
gh api graphql -f query='
  query {
    repository(owner:"owner", name:"repo") {
      discussion(number:42) {
        title body comments(first:20) { nodes { body author { login } } }
      }
    }
  }
'
```

## Releases & Tags

```bash
# List releases
gh release list -R owner/repo --limit 10

# View a specific release with notes
gh release view v1.2.3 -R owner/repo

# Download release assets
gh release download v1.2.3 -R owner/repo -D ./downloads

# Create a release
gh release create v1.2.3 -R owner/repo --title "v1.2.3" --notes "Release notes here"
```

## GitHub Actions (CI/CD)

```bash
# List workflow runs
gh run list -R owner/repo --limit 10

# View a specific run
gh run view 789 -R owner/repo

# Re-run a failed workflow
gh run rerun 789 -R owner/repo

# View run logs
gh run view 789 -R owner/repo --log

# Watch a run in real time
gh run watch 789 -R owner/repo
```

## Direct API Access (`gh api`)

For anything not covered by a dedicated `gh` command, use `gh api` to hit any REST endpoint.
Authentication and headers are handled automatically.

```bash
# GET request
gh api repos/owner/repo/labels

# POST with a JSON body
gh api repos/owner/repo/labels \
  -f name="bug" -f color="ff0000"

# Paginated listing
gh api repos/owner/repo/stargazers --paginate --jq '.[].login'

# GraphQL queries
gh api graphql -f query='query { viewer { login } }'
```

## Gists

```bash
# Create a gist
gh gist create file.txt --public

# View a gist
gh gist view abc123

# Edit a gist
gh gist edit abc123 file.txt
```

## Tips & Tricks

- **`-R owner/repo`** — Works from any directory; no need to be inside a clone.
- **`--json field1,field2`** — Always prefer structured JSON output for programmatic use.
- **`--jq '.field'`** — Chain with `jq` expressions for inline filtering.
- **`--web`** — Opens the GitHub UI in a browser as a last resort (e.g., to show the user something visually).
- **`gh api --paginate`** — Automatically follows `Link` headers to fetch all pages.
- **Combine with bash tools** — Pipe `gh` output into `jq`, `grep`, `sort`, `wc`, etc. for analysis.

## Decision Guide

| Task | Use This |
|------|----------|
| Read a file in a GitHub repo | `gh api repos/owner/repo/contents/path` |
| Browse repo tree | `gh api repos/owner/repo/git/trees/main?recursive=1` |
| Search issues/PRs | `gh search issues "query" --owner owner` |
| Read an issue thread | `gh issue view N -R owner/repo --comments` |
| Read a PR thread + diff | `gh pr view N -R owner/repo --comments` + `gh pr diff N` |
| Check CI status | `gh run list -R owner/repo --limit 5` |
| View release notes | `gh release view v1.2.3 -R owner/repo` |
| Clone for building/editing | `gh repo clone owner/repo -- --depth=1` |
| Anything else on GitHub | `gh api ...` |
