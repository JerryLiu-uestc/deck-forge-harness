---
name: deck-forge
description: Use this skill when the user wants an end-to-end AI presentation workflow that combines Playwright/browser capture, frontend-designed slide canvases, harness automation, and PPTX export or verification. Trigger for requests like "按 Playwright MCP + frontend-design + harness-anything 做 PPT 插件", "build a deck workflow", "capture website into PPT", or "automate a presentation pipeline".
---

# DeckForge

DeckForge is the orchestrator skill for a presentation workflow built around three lanes:

1. **Capture**: collect screenshots, DOM text, assets, and source URLs with Playwright MCP, the Browser plugin, or local Playwright.
2. **Design**: build each slide as a frontend canvas using `frontend-design` when available; otherwise create HTML/CSS/SVG with the same discipline.
3. **Harness**: write a small task-specific automation wrapper that renders, exports, checks, and iterates until the deck is deliverable.

## Default Pipeline

Use this sequence unless the user gives a narrower task:

1. Create a `deckforge/` workspace under the project:
   - `captures/` for screenshots and source pulls
   - `slides/` for HTML slide canvases
   - `renders/` for PNG previews
   - `pptx/` for generated decks
   - `harness/` for project-specific scripts
2. Capture source material:
   - Prefer a Playwright MCP/browser tool if available.
   - Use local Playwright only when no MCP/browser tool is available.
   - Store screenshots and a short `sources.json`.
3. Design slides:
   - If `frontend-design` is installed, use it for visual direction and component quality.
   - Keep slides as fixed 16:9 canvases, one HTML file per deck or per slide.
   - Avoid relying on PowerPoint layout while designing; PowerPoint is an export target.
4. Build a harness:
   - Use `harness-anything` to create a small adapter for the exact local tools in use.
   - Prefer deterministic file operations over GUI automation.
5. Export:
   - For highest fidelity, screenshot each HTML slide and place the PNGs into PPTX.
   - For editability, recreate selected text/shapes with `python-pptx` only where needed.
6. Verify:
   - Render PPTX to PDF/images.
   - Check page count, nonblank output, screenshot contact sheet, and obvious cropping.
   - Iterate before final response.

## Local CLI

The plugin includes `scripts/deckforge.py` for common filesystem and export tasks:

```bash
python3 ~/plugins/deck-forge-harness/scripts/deckforge.py init --project deckforge
```

```bash
python3 ~/plugins/deck-forge-harness/scripts/deckforge.py html-to-png \
  --html deckforge/slides/index.html \
  --out-dir deckforge/renders
```

```bash
python3 ~/plugins/deck-forge-harness/scripts/deckforge.py images-to-pptx \
  --input-dir deckforge/renders \
  --output deckforge/pptx/deck.pptx
```

```bash
python3 ~/plugins/deck-forge-harness/scripts/deckforge.py render-pptx \
  --pptx deckforge/pptx/deck.pptx \
  --out-dir deckforge/qa
```

## Decision Rules

- Use browser/Playwright capture for websites, dashboards, app screens, or live references.
- Use frontend slide canvases for original design work.
- Use direct PPTX file editing for assembly and light modifications.
- Use PowerPoint/WPS GUI automation only when the user specifically needs behavior that cannot be done through file operations.
- If `frontend-design`, Playwright MCP, or a GUI automation harness is unavailable, state the fallback and keep moving with local HTML/Playwright/LibreOffice where possible.

## Completion Evidence

Final responses should include:

- generated PPTX path;
- capture/source path when relevant;
- render/contact-sheet path;
- verification commands run;
- unavailable tools or fallback choices.
