---
name: conventional-commit
description: Structure commit messages following the Conventional Commits specification. Use when drafting commit messages before coding or reviewing commit message quality.
---

# Conventional Commits

Structure commit messages using the Conventional Commits specification for clear, consistent,
and machine-readable commit history.

## When to Use

- Drafting commit messages before starting coding
- Reviewing commit message quality
- Establishing team commit message conventions
- Creating automated changelogs or version management

## Core Principles

Commit messages must follow the Conventional Commits specification: https:
//www.conventionalcommits.org/en/v1.0.0/

## Format

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Commit Types

| Type      | Description                                                                 |
| --------- | --------------------------------------------------------------------------- |
| `feat`    | A new feature                                                              |
| `fix`     | A bug fix                                                                  |
| `docs`    | Documentation only changes                                                 |
| `style`   | Code style changes (formatting, semi-colons, etc.) - no code logic change  |
| `refactor`| Code changes that neither fix a bug nor add a feature                      |
| `perf`    | Performance improvements                                                    |
| `test`    | Adding or updating tests                                                   |
| `build`   | Build system or external dependencies changes                              |
| `ci`      | CI configuration changes and scripts                                       |
| `chore`   | Other changes that don't modify src or test files                          |
| `revert`  | Reverts a previous commit                                                  |

## Format Rules

### Header

- **Format:** `<type>[optional scope]: <description>`
- **Description rules:**
  - Must be in imperative, present tense (e.g., "add feature" not "added feature" or "adds feature")
  - No capitalization at the start
  - No period at the end
  - Keep concise (typically under 50 characters total)

```text
feat: add dark mode toggle
fix: remove blocking overlay on login button
feat(auth): upgrade OAuth client library
```

### Body

- Bulleted list detailing each specific change or requirement
- Provide context on *what* and *why*, not just *how*
- Every detail from the intent should be captured as a bullet point
- Each bullet point should also be in imperative mood
- Wrap at 72 characters

```text
feat(ui): add dark mode toggle to header

- create new theme toggle button component
- implement dark mode state management in React context
- update Tailwind configuration with dark theme color palette
```

### Footer

- Use for breaking changes and issues references
- Breaking changes MUST be in the footer and start with `BREAKING CHANGE:`
- May reference issues using a format like `Closes #123` or `Related to #456`

```text
feat(api): change return type

BREAKING CHANGE: Return type changed from string to object

Closes #123
```

## Scope

- Optional part of the commit header
- Enclosed in parentheses after the type
- Identifies the part of the codebase affected
- Examples: `auth`, `ui`, `api`, `database`, `docs`

```text
feat(auth): add OAuth2 provider support
fix(ui): correct alignment in navbar
```

## Examples

### Feature with multiple changes

```text
feat(ui): add dark mode toggle to header

- create new theme toggle button component
- implement dark mode state management in React context
- update Tailwind configuration with dark theme color palette
- add CSS transitions for theme switching
- persist theme preference in local storage
```

### Bug fix

```text
fix(auth): remove blocking overlay on login button

- adjust z-index of the overlay div to sit behind the button
- ensure pointer-events do not intercept clicks on the login CTA
```

### Documentation

```text
docs: update installation instructions

- clarify dependencies for Node.js 18+
- add troubleshooting section for Windows users
- update examples with latest API changes
```

### Breaking change

```text
feat(api): migrate to REST v2 endpoints

BREAKING CHANGE: All API endpoints prefixed with /api/v2
- old endpoints will still be available until version 3.0
- update client SDKs to use new endpoint structure
- update authentication middleware
- update API documentation
```

### Refactor

```text
refactor(database): replace ORM with raw SQL queries

- improve query performance by 40%
- reduce bundle size by 15%
- add query result caching layer
- update error handling for database operations
```

## Common Mistakes to Avoid

### ❌ Wrong tense

```text
feat: added dark mode
feat: adds dark mode
```

### ✅ Correct

```text
feat: add dark mode
```

### ❌ Capitalization or period in header

```text
feat: Add dark mode toggle.
feat(add dark mode toggle)
```

### ✅ Correct

```text
feat: add dark mode toggle
```

### ❌ Missing context in body

```text
fix: remove overlay

- fix z-index
```

### ✅ Correct

```text
fix: remove blocking overlay on login button

- adjust z-index of the overlay div to sit behind the button
- ensure pointer-events do not intercept clicks on the login CTA
```

## Quick Reference

| Type    | Template                                                      |
| ------- | ------------------------------------------------------------- |
| feat    | `feat: <short description>`                                  |
| fix     | `fix: <short description>`                                   |
| docs    | `docs: <short description>`                                  |
| style   | `style: <short description>`                                 |
| refactor| `refactor: <short description>`                              |
| perf    | `perf: <short description>`                                  |
| test    | `test: <short description>`                                  |
| build   | `build: <short description>`                                 |
| ci      | `ci: <short description>`                                    |
| chore   | `chore: <short description>`                                 |
| revert  | `revert: <original commit message>`                          |

---

**Source:** [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

