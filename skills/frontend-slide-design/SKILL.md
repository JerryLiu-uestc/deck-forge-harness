---
name: frontend-slide-design
description: Use this skill when designing presentation slides as HTML/CSS/React/SVG frontend canvases before exporting them to PPTX. Use especially with DeckForge workflows, frontend-design-inspired slide visuals, or when a user wants richer visual quality than native PowerPoint shape editing.
---

# Frontend Slide Design

Design slides as frontend canvases first, then export to images or PPTX.

## Canvas Contract

- Use 16:9 fixed logical size: `1280x720` or `1920x1080`.
- Keep each slide in a stable container with explicit dimensions.
- Use real text in HTML when screenshots are the export path; use separate PPTX reconstruction only for content that must remain editable.
- Avoid tiny text, uncontrolled wrapping, and elements placed relative to viewport width.
- Use actual captured images/screenshots when the slide discusses a real product, site, app, or game.

## If `frontend-design` Exists

When the Anthropic/Claude `frontend-design` skill/plugin is installed in the active environment, use it as the visual design lane. Treat this skill as the deck-specific wrapper:

- `frontend-design` decides UI polish, visual hierarchy, and frontend implementation quality.
- `frontend-slide-design` keeps the output constrained to deck canvases and exportability.

If `frontend-design` is not installed, implement directly with the local frontend stack and follow the same canvas contract.

## Export Patterns

High fidelity:

1. Render HTML slide canvases with Playwright.
2. Save one PNG per slide.
3. Assemble full-slide PNGs into PPTX.
4. Render PPTX back to PNG previews and inspect.

Editable hybrid:

1. Use HTML/SVG as design reference.
2. Rebuild essential text and simple shapes in PPTX.
3. Keep complex screenshots/photos as raster image layers.

## QA Checklist

- Slide count matches the plan.
- Every slide preview is nonblank.
- Text does not overflow or touch edges.
- Captured website/app screenshots are legible.
- The final PPTX render matches the HTML preview closely enough for the requested fidelity.
