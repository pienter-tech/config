---
name: review-changes
description: Review recent repository changes for correctness, security, performance, maintainability, and missing tests. Use when the user asks for a code review, review of commits, or quality assessment before merge.
context: fork
agent: review
---

# Review Changes

Perform a practical review focused on high-impact issues first.

## Inputs to inspect

- `git log --oneline -10 --graph --decorate`
- `git status --porcelain`
- `git diff --cached --stat`
- `git diff --stat`
- `git diff HEAD~5..HEAD --name-only`

Read the actual diffs for files that appear significant.

## Review priorities

1. Correctness and regressions
2. Security and secret exposure
3. Performance risks
4. Maintainability and architecture fit
5. Testing and documentation gaps

## Output format

Provide findings ordered by severity:

- **Critical**: Must fix before merge
- **Major**: Should fix, may cause problems
- **Minor**: Suggestions for improvement

For each finding include:
- Why it matters
- Concrete fix guidance
- File reference (`file_path:line_number`)

If no issues are found, state that explicitly and note residual risks.
