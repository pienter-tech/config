---
description: Review recent changes and commits
agent: review
---

Review the recent changes in this repository:

## Recent commits:
!`git log --oneline -10 --graph --decorate`

## Current working tree status:
!`git status --porcelain`

## Staged changes:
!`git diff --cached --stat`

## Unstaged changes:
!`git diff --stat`

## Detailed diff of recent changes:
!`git diff HEAD~5..HEAD --name-only`

Please analyze these changes and provide:

1. **Code Quality Assessment**: Review for potential bugs, performance issues, or code smells
2. **Security Review**: Check for security vulnerabilities, exposed secrets, or unsafe practices  
3. **Best Practices**: Ensure code follows language conventions and project standards
4. **Architecture Impact**: Assess how changes affect overall system design
5. **Testing Coverage**: Identify areas that may need additional tests
6. **Documentation**: Note if any changes require documentation updates
7. **Breaking Changes**: Flag any potentially breaking changes
8. **Suggestions**: Provide specific recommendations for improvements

Focus on the most impactful issues and provide actionable feedback.