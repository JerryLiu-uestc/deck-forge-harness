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
6. Windows WPS/MS Office COM only when available and explicitly useful.
7. PowerPoint/WPS GUI automation only as a last mile fallback.

## Office Backend Matrix

Borrow the `harness-anything` / `cli-anything-wps` idea as an adapter pattern, not as a universal dependency:

| Platform | Preferred Office control | Use for | Do not claim |
| --- | --- | --- | --- |
| Windows | WPS COM or MS Office COM through `pywin32` | live WPS/PowerPoint creation, exact Office rendering, PDF export | cross-platform availability |
| macOS | `python-pptx` plus LibreOffice headless | PPTX file assembly, conversion, render QA | live WPS COM automation |
| Linux | `python-pptx` plus LibreOffice headless | batch creation/conversion/QA | PowerPoint/WPS UI control |

Run `python3 ~/plugins/html-to-editable-ppt/scripts/html_to_editable_ppt.py doctor` before choosing a backend when the environment is uncertain.

## JSON Element Router Pattern

For structured decks, prefer a small JSON schema with typed elements over ad hoc code. This mirrors the useful part of WPS COM examples while staying portable.

Minimal schema:

```json
{
  "canvas": {"w": 1280, "h": 720},
  "slides": [
    {
      "background": "#FFFFFF",
      "elements": [
        {"type": "text", "x": 80, "y": 60, "w": 900, "h": 70, "text": "Title", "fs": 40, "bold": true},
        {"type": "card", "x": 80, "y": 160, "w": 360, "h": 160, "fill": "#F8FAFC"},
        {"type": "image", "x": 520, "y": 150, "w": 620, "h": 360, "file": "capture.png"}
      ]
    }
  ]
}
```

Build it with:

```bash
python3 ~/plugins/html-to-editable-ppt/scripts/html_to_editable_ppt.py schema-to-pptx \
  --schema editable-ppt/harness/deck-schema.json \
  --output editable-ppt/pptx/deck.pptx
```

Supported portable element types are intentionally small: `text`, `rect`, `rrect`/`card`, `image`, and `line`. Add project-specific routers in `editable-ppt/harness/` only when the deck repeatedly needs custom components such as timelines, stat cards, or tables.

## GUI App Rule

Only build GUI automation for WPS or PowerPoint when:

- the user explicitly asks for WPS/PowerPoint behavior;
- direct PPTX file editing cannot perform the task;
- the workflow can be verified by exported files or screenshots.
- the platform exposes a stable automation surface. On macOS, treat WPS as manual unless a verified scriptable interface is available.

## Output Contract

Report:

- what harness was created;
- which tool surfaces were used;
- exact commands run;
- outputs produced;
- what remains manual because no stable automation surface exists.
