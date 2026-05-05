# Markdown to Confluence Conversion Rules

Detailed rules for converting local markdown design documents into Confluence-compatible HTML.

---

## Conversion Pipeline

```
1. Read local .md file
2. Split: YAML frontmatter | markdown body
3. Parse markdown body into AST (abstract syntax tree)
4. Transform each node to Confluence HTML
5. Prepend document header (status lozenge, epic link, date)
6. Return complete HTML string
```

---

## Element-by-Element Conversion

### Headings

```markdown
# Heading 1      ->  <h1>Heading 1</h1>
## Heading 2     ->  <h2>Heading 2</h2>
### Heading 3    ->  <h3>Heading 3</h3>
#### Heading 4   ->  <h4>Heading 4</h4>
##### Heading 5  ->  <h5>Heading 5</h5>
###### Heading 6 ->  <h6>Heading 6</h6>
```

### Paragraphs

```markdown
Regular text paragraph.    ->  <p>Regular text paragraph.</p>

Two paragraphs separated   ->  <p>Two paragraphs separated
by a blank line.               by a blank line.</p>
```

### Inline Formatting

```markdown
**bold**          ->  <strong>bold</strong>
*italic*          ->  <em>italic</em>
`inline code`     ->  <code>inline code</code>
[text](url)       ->  <a href="url">text</a>
~~strikethrough~~ ->  <s>strikethrough</s>
```

### Unordered Lists

```markdown
- Item 1              ->  <ul>
- Item 2                    <li>Item 1</li>
  - Nested item             <li>Item 2
                               <ul><li>Nested item</li></ul>
                             </li>
                           </ul>
```

### Ordered Lists

```markdown
1. Step 1             ->  <ol>
2. Step 2                   <li>Step 1</li>
3. Step 3                   <li>Step 2</li>
                            <li>Step 3</li>
                          </ol>
```

### Task Lists (Checkboxes)

```markdown
- [ ] Unchecked       ->  <ul data-type="task-list">
- [x] Checked               <li data-type="task-item">
                               <input type="checkbox"> Unchecked
                             </li>
                             <li data-type="task-item">
                               <input type="checkbox" checked> Checked
                             </li>
                           </ul>
```

### Tables

```markdown
| Col A | Col B |        ->  <table>
|-------|-------|              <thead>
| Val 1 | Val 2 |               <tr><th>Col A</th><th>Col B</th></tr>
| Val 3 | Val 4 |             </thead>
                               <tbody>
                                 <tr><td>Val 1</td><td>Val 2</td></tr>
                                 <tr><td>Val 3</td><td>Val 4</td></tr>
                               </tbody>
                             </table>
```

**Table rules:**
- Always include `<thead>` and `<tbody>`
- Escape pipe characters in cell content: `\|`
- Empty cells: use `<td></td>` (not `<td>&nbsp;</td>`)

### Code Blocks

````markdown
```typescript                ->  <pre><code class="language-typescript">
const x = 42;                    const x = 42;
```                              </code></pre>
````

**IMPORTANT**: Always specify the language identifier. If the language is unknown, use `text`:
```html
<pre><code class="language-text">some output</code></pre>
```

**HTML escaping in code blocks**: Escape `<`, `>`, `&` inside code blocks:
- `<` -> `&lt;`
- `>` -> `&gt;`
- `&` -> `&amp;`

### Mermaid Diagrams

````markdown
```mermaid                   ->  <ac:structured-macro ac:name="mermaid">
graph TD                           <ac:plain-text-body><![CDATA[
    A --> B                        graph TD
```                                    A --> B
                                   ]]></ac:plain-text-body>
                                 </ac:structured-macro>
````

**Fallback** (if Mermaid macro not available):
```html
<div data-type="panel-note"><p>Diagram (render with a Mermaid-compatible viewer):</p></div>
<pre><code class="language-text">
graph TD
    A --> B
</code></pre>
```

### Blockquotes

```markdown
> This is a quote        ->  <blockquote><p>This is a quote</p></blockquote>

> **Status**: DRAFT      ->  Convert to status header pattern (see below)
```

### Horizontal Rules

```markdown
---                       ->  <hr />
```

### Images

```markdown
![Alt text](url)          ->  <img src="url" alt="Alt text" />
```

**Note**: For images hosted externally, Confluence will render them inline. For images that should be attachments, they need to be uploaded separately via the Confluence API (not currently supported by this plugin — use external URLs or Confluence-hosted images).

---

## Special Conversions

### Status Header Line

The status line at the top of each design doc gets special treatment:

```markdown
> **Status**: DRAFT | **Last Updated**: 2026-05-05 | **Epic**: SPE-1019
```

Converts to:

```html
<p>
  <strong>Status</strong>: <span data-type="status" data-color="yellow">DRAFT</span> |
  <strong>Epic</strong>: <a href="https://wisersolutions.atlassian.net/browse/SPE-1019" data-card-appearance="inline">SPE-1019</a> |
  <strong>Last Updated</strong>: <time datetime="2026-05-05">May 5, 2026</time>
</p>
<hr />
```

Status-to-color mapping:
| Status | Color |
|--------|-------|
| DRAFT | yellow |
| IN REVIEW | blue |
| APPROVED | green |
| DEPRECATED | red |
| ON HOLD | neutral |

### Jira Ticket References

Any Jira ticket key pattern (e.g., `SPE-1019`, `ABC-123`) in the body text should be converted to a smart link:

```markdown
See SPE-1019 for details.
```

Converts to:

```html
<p>See <a href="https://wisersolutions.atlassian.net/browse/SPE-1019" data-card-appearance="inline">SPE-1019</a> for details.</p>
```

**Detection pattern**: `[A-Z]{2,10}-\d+` (2-10 uppercase letters, hyphen, one or more digits)

**IMPORTANT**: Do NOT convert ticket references inside code blocks or code spans.

---

## Reverse Conversion (Confluence HTML -> Local Markdown)

When pulling from Confluence (via `/pull-doc`), the page content is fetched as markdown using `contentFormat: "markdown"`. The MCP API handles this conversion. However, some Confluence-specific elements may not round-trip perfectly:

### Elements That May Need Manual Cleanup

| Confluence Element | Markdown Result | Action |
|-------------------|-----------------|--------|
| Status lozenge | May become plain text | Re-detect and mark in frontmatter |
| Panels | May become blockquotes | Acceptable — panels are added back on publish |
| Smart links | May become regular links | Acceptable |
| Task lists | May become regular checkboxes | Usually preserved |
| Mermaid macro | May become code block | Need to re-tag as mermaid |
| Expand/collapse | May flatten | Acceptable |

### Frontmatter Reconstruction

When pulling a page that was NOT originally created by this plugin (no existing frontmatter), construct frontmatter by:

1. Setting `confluencePageId` from the page ID
2. Detecting `type` from page title (match against configured `titlePrefix` values)
3. Detecting `jiraEpic` from page labels or title
4. Setting `status` from status lozenge text in the page body (if found)
5. Setting sync timestamps to current time

---

## Content Sanitization

Before publishing to Confluence, sanitize the HTML:

1. **Remove frontmatter**: Strip everything between `---` markers
2. **Escape user content**: Ensure no raw HTML injection in user-provided text
3. **Validate table structure**: Every `<tr>` must have matching `<th>` or `<td>` counts
4. **Check heading hierarchy**: No skipped levels (h1 -> h3 without h2) — warn but don't block
5. **Verify Mermaid syntax**: Basic syntax check on Mermaid blocks before publishing
6. **Strip trailing whitespace**: Clean up empty paragraphs and excess whitespace
