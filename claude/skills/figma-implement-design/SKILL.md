---
name: figma-implement-design
description: "Translate Figma nodes into production-ready code with 1:1 visual fidelity using the Figma MCP workflow (design context, screenshots, assets, and project-convention translation). Trigger when the user provides Figma URLs or node IDs, or asks to implement designs or components that must match Figma specs. Requires a working Figma MCP server connection."
argument-hint: "[figma-url]"
---

# Implement Design

Translate Figma designs into production-ready code with pixel-perfect accuracy.

## Prerequisites

- Figma MCP server must be connected and accessible.
- User provides a Figma URL (`https://figma.com/design/:fileKey/:fileName?node-id=1-2`) or selects a node in the Figma desktop app (figma-desktop MCP only).

## Required Workflow

Follow these steps in order. Do not skip steps.

### Step 1: Get Node ID

**From URL**: Extract `:fileKey` (segment after `/design/`) and `node-id` query parameter.
**From desktop app** (figma-desktop MCP): No URL needed, tools use the current selection.

### Step 2: Fetch Design Context

```
get_design_context(fileKey=":fileKey", nodeId="1-2")
```

If the response is truncated:
1. Run `get_metadata(fileKey, nodeId)` for the node map.
2. Fetch individual child nodes with `get_design_context`.

### Step 3: Capture Visual Reference

```
get_screenshot(fileKey=":fileKey", nodeId="1-2")
```

Keep the screenshot accessible throughout implementation.

### Step 4: Download Required Assets

- Use `localhost` sources from Figma MCP directly.
- Do NOT import new icon packages or create placeholders.

### Step 5: Translate to Project Conventions

- Treat Figma MCP output as design representation, not final code style.
- Replace Tailwind utilities with project design system tokens.
- Reuse existing components instead of duplicating.
- Respect existing routing, state management, and data-fetch patterns.

### Step 6: Achieve 1:1 Visual Parity

- Use design tokens from Figma where available, avoid hardcoded values.
- When project tokens differ from Figma values, prefer project tokens but adjust to maintain visual fidelity.
- Follow WCAG accessibility requirements.

### Step 7: Validate Against Figma

Compare final UI against the screenshot:
- Layout (spacing, alignment, sizing)
- Typography (font, size, weight, line height)
- Colors match exactly
- Interactive states (hover, active, disabled)
- Responsive behavior follows Figma constraints
- Assets render correctly

## Rules

- Always fetch `get_design_context` and `get_screenshot` before implementing.
- Check for existing components before creating new ones.
- When in doubt, prefer the project's design system over literal Figma translation.
- Document any deviations from the Figma design in code comments.
