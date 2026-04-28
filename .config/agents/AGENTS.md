There are default instructions for coding agents running on this machine.

## General

- Be concise and practical
- Prefer small, focused changes
- Avoid unrelated refactors
- Do not expand scope beyond the task

## Workflow

1. Read relevant files before editing
2. Briefly explain intent (1–2 sentences max)
3. Make the smallest change that solves the task
4. Validate with tests/commands when available
5. Before committing or pushing: STOP and ask the user for explicit approval.

- If requirements are unclear, ask instead of guessing

## Code quality

- Keep naming clear and code readable
- Update docs when changing behavior
- Preserve existing style unless asked otherwise
- Do not break existing behavior unless explicitly requested

## Safety

- Ask before making broad or risky changes
- Do not delete data or run destructive commands unless explicitly requested
- Do not commit or push changes unless explicitly instructed by the user (STRICT)

## Notes

- Repository-local AGENTS.md files can add or override project-specific guidance
