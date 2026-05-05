---
name: confluence-authoring
description: Background knowledge for writing design documents to Confluence. Covers HTML content formatting, Mermaid diagram handling, status lozenges, markdown-to-Confluence conversion rules, and document type templates. Applied automatically during design-doc commands.
user-invocable: false
---

# Confluence Authoring Knowledge

This skill provides the foundational knowledge for converting local markdown design documents into Confluence-compatible HTML and managing the document lifecycle on Confluence.

## Content Format Strategy

The wiser-design-docs plugin uses **HTML** as the Confluence content format (`contentFormat: "html"`), not raw ADF JSON. Reasons:

1. **Readability**: HTML is human-readable and debuggable
2. **Full fidelity**: HTML supports all Confluence-specific elements via `data-type` attributes
3. **Round-trip safety**: Content read back as markdown preserves structure
4. **Macro support**: Structured macros (like Mermaid) can be embedded in HTML

## Conversion Pipeline

```
Local Markdown (.md)
  |
  v
Parse frontmatter (YAML) + body (markdown)
  |
  v
Convert body to Confluence HTML
  - Standard elements: headings, lists, tables, code blocks, links
  - Mermaid blocks -> structured macro HTML
  - Status indicators -> data-type lozenges
  - Selective use of panels/expand when warranted
  |
  v
Publish via MCP (createConfluencePage / updateConfluencePage)
  |
  v
Update local frontmatter with sync metadata
```

## Key Rules

1. **Local copy is the source of truth** for content generation and editing
2. **Confluence is the publishing target** and collaboration surface
3. **Frontmatter tracks sync state** — never delete or corrupt frontmatter fields
4. **Conflicts are always user-resolved** — never auto-merge or auto-overwrite
5. **Confluence macros are used sparingly** — only when content genuinely requires them
6. **Diagrams use Mermaid** — with fallback to code blocks if the macro isn't available
7. **Code blocks always specify language** — for proper syntax highlighting

## References

- `confluence-html-patterns.md` — Complete HTML element reference for Confluence
- `doc-type-templates.md` — Default templates for each design document type
- `md-to-confluence.md` — Detailed markdown-to-Confluence conversion rules
