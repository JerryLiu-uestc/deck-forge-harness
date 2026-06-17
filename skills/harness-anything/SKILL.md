---
name: harness-anything
description: Use this skill when Codex needs to create a small task-specific automation harness around an arbitrary local tool, browser flow, CLI, GUI app, or file format. In deck workflows, use it to coordinate Playwright capture, frontend rendering, PPTX generation, LibreOffice export, WPS/PowerPoint fallbacks, and verification.
---

# Harness Anything

A harness is a thin, task-specific automation wrapper. It should make a fragile manual workflow repeatable without pretending every tool has a clean API.

## Build Order

1. Identify the tool surfaces:
   - CLI available?
   - file format editable directly?
   - browser/MCP available?
   - GUI automation required?
2. Prefer the most deterministic surface:
   - file edits before GUI automation;
   - browser automation before visual mouse driving;
   - official CLI before shelling through UI apps.
3. Write a minimal script or command group under `harness/` or `scripts/`.
4. Make the harness observable:
   - log commands;
   - emit output paths;
   - fail nonzero on missing tools or failed verification.
5. Run the harness at least once and inspect outputs.

## Deck Harness Pattern

For PPT/deck work, default to:

```text
capture -> frontend render -> image/PPTX export -> PDF render -> PNG QA -> final deck
```

Tool preference:

1. Playwright MCP or Browser plugin for capture and browser screenshots.
2. Local Playwright CLI/script when MCP is unavailable.
3. `python-pptx` for PPTX creation/light edits.
4. LibreOffice `soffice` for PDF export.
5. Poppler `pdftoppm` for preview images.
6. PowerPoint/WPS GUI automation only as a last mile fallback.

## GUI App Rule

Only build GUI automation for WPS or PowerPoint when:

- the user explicitly asks for WPS/PowerPoint behavior;
- direct PPTX file editing cannot perform the task;
- the workflow can be verified by exported files or screenshots.

## Output Contract

Report:

- what harness was created;
- which tool surfaces were used;
- exact commands run;
- outputs produced;
- what remains manual because no stable automation surface exists.
