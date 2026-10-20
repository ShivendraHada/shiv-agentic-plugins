# Confluence HTML Patterns Reference

This reference covers all HTML patterns supported by the Confluence MCP API when using `contentFormat: "html"`.

## Standard HTML Elements

### Headings
```html
<h1>Page Title</h1>
<h2>Major Section</h2>
<h3>Subsection</h3>
<h4>Sub-subsection</h4>
<h5>Minor heading</h5>
<h6>Smallest heading</h6>
```

### Paragraphs and Inline Formatting
```html
<p>Regular paragraph text.</p>
<p><strong>Bold text</strong> and <em>italic text</em>.</p>
<p><a href="https://example.com">Link text</a></p>
<p><code>inline code</code></p>
```

### Lists
```html
<!-- Unordered list -->
<ul>
  <li>Item one</li>
  <li>Item two
    <ul>
      <li>Nested item</li>
    </ul>
  </li>
</ul>

<!-- Ordered list -->
<ol>
  <li>First step</li>
  <li>Second step</li>
</ol>
```

### Tables
```html
<table>
  <thead>
    <tr>
      <th>Header 1</th>
      <th>Header 2</th>
      <th>Header 3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Cell 1</td>
      <td>Cell 2</td>
      <td>Cell 3</td>
    </tr>
  </tbody>
</table>
```

### Code Blocks
```html
<!-- Always specify the language for syntax highlighting -->
<pre><code class="language-typescript">
interface AuthConfig {
  provider: string;
  clientId: string;
  scopes: string[];
}
</code></pre>

<pre><code class="language-python">
def authenticate(token: str) -> User:
    return verify_jwt(token)
</code></pre>

<pre><code class="language-sql">
SELECT u.id, u.email
FROM users u
JOIN sessions s ON s.user_id = u.id
WHERE s.expires_at > NOW();
</code></pre>
```

Supported language identifiers: `typescript`, `javascript`, `python`, `java`, `go`, `rust`, `sql`, `bash`, `yaml`, `json`, `xml`, `html`, `css`, `graphql`, `kotlin`, `swift`, `csharp`, `ruby`, `php`, `scala`, `hcl`

### Horizontal Rule
```html
<hr />
```

---

## Confluence-Specific Elements (data-type attributes)

**IMPORTANT**: Use these only when the content genuinely warrants it. Do not decorate every document with panels and lozenges.

### Status Lozenge
Use at the top of design documents to indicate document status.

```html
<!-- Draft -->
<span data-type="status" data-color="yellow">DRAFT</span>

<!-- In Review -->
<span data-type="status" data-color="blue">IN REVIEW</span>

<!-- Approved -->
<span data-type="status" data-color="green">APPROVED</span>

<!-- Deprecated -->
<span data-type="status" data-color="red">DEPRECATED</span>

<!-- On Hold -->
<span data-type="status" data-color="neutral">ON HOLD</span>
```

### Panels (Info, Warning, Note, Success, Error)
Use when content has a specific semantic purpose that a plain paragraph doesn't convey.

```html
<!-- Info: Important context readers should know -->
<div data-type="panel-info"><p>This service handles PII data and is subject to GDPR requirements.</p></div>

<!-- Warning: Risks or caveats -->
<div data-type="panel-warning"><p>This migration requires a maintenance window. Coordinate with SRE team.</p></div>

<!-- Note: Supplementary information -->
<div data-type="panel-note"><p>This decision supersedes ADR-042 from Q3 2025.</p></div>

<!-- Success: Positive outcome or confirmation -->
<div data-type="panel-success"><p>Load testing confirmed the system handles 10K concurrent users.</p></div>

<!-- Error: Critical issue or blocker -->
<div data-type="panel-error"><p>BLOCKED: Waiting on security review before implementation can proceed.</p></div>
```

### Expand/Collapse
Use for lengthy details that most readers can skip.

```html
<details>
  <summary>Detailed API Response Schema</summary>
  <pre><code class="language-json">{
  "id": "string",
  "status": "active" | "inactive",
  "metadata": { ... }
}</code></pre>
</details>
```

### Task List
```html
<ul data-type="task-list">
  <li data-type="task-item"><input type="checkbox"> Security review completed</li>
  <li data-type="task-item"><input type="checkbox"> Load testing passed</li>
  <li data-type="task-item"><input type="checkbox" checked> Architecture diagram updated</li>
</ul>
```

### Decision List
```html
<ul data-type="decision-list">
  <li data-type="decision-item" data-state="DECIDED">Use PostgreSQL for primary data store</li>
  <li data-type="decision-item" data-state="UNDECIDED">Caching strategy (Redis vs Memcached)</li>
</ul>
```

### Two-Column Layout
Use for side-by-side comparisons (e.g., current vs proposed, option A vs option B).

```html
<section data-type="layout-two-equal">
  <div data-type="column">
    <h3>Current Architecture</h3>
    <p>Monolithic service handling all requests...</p>
  </div>
  <div data-type="column">
    <h3>Proposed Architecture</h3>
    <p>Microservices with dedicated auth service...</p>
  </div>
</section>
```

### Smart Link (Inline Preview)
Use for Jira ticket references within the document.

```html
<a href="https://<cloudId>/browse/PROJ-1019" data-card-appearance="inline">SPE-1019</a>
```

### Date
```html
<time datetime="2026-05-05">May 5, 2026</time>
```

### User Mention
```html
<span data-type="mention" data-user-id="ACCOUNT_ID">@John Smith</span>
```

---

## Mermaid Diagram Macro

Confluence supports Mermaid diagrams via a structured macro (requires the Mermaid plugin to be installed on the Confluence instance).

```html
<ac:structured-macro ac:name="mermaid">
  <ac:plain-text-body><![CDATA[
graph TD
    A[Client App] -->|HTTPS| B[API Gateway]
    B --> C[Auth Service]
    B --> D[Core Service]
    C --> E[(User DB)]
    D --> F[(Product DB)]
  ]]></ac:plain-text-body>
</ac:structured-macro>
```

### Fallback When Mermaid Plugin Not Available

If publish fails due to the Mermaid macro not being recognized, convert the diagram to a code block with a note:

```html
<div data-type="panel-note"><p>Diagram (render with a Mermaid viewer):</p></div>
<pre><code class="language-mermaid">
graph TD
    A[Client App] -->|HTTPS| B[API Gateway]
    B --> C[Auth Service]
</code></pre>
```

---

## Document Header Pattern

Every design document should start with a standard header:

```html
<p>
  <strong>Status</strong>: <span data-type="status" data-color="yellow">DRAFT</span> |
  <strong>Epic</strong>: <a href="https://<cloudId>/browse/PROJ-1019" data-card-appearance="inline">SPE-1019</a> |
  <strong>Last Updated</strong>: <time datetime="2026-05-05">May 5, 2026</time>
</p>
<hr />
```

---

## Things to AVOID

- **Do NOT wrap content in `<html>`, `<head>`, or `<body>` tags** — Confluence API rejects these
- **Do NOT use CSS classes for styling** — use `data-type` attributes for Confluence elements
- **Do NOT use `<div>` without `data-type`** — plain divs may not render correctly
- **Do NOT nest structured macros** — Confluence may not support it
- **Do NOT use `<br>` excessively** — use `<p>` tags for paragraphs
- **Do NOT overuse panels** — a page full of colored boxes is harder to read than plain text
