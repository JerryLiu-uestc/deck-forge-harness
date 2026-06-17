# HTML to Editable PPT Demo

This folder contains a small editable PowerPoint demo generated through the HTML to Editable PPT schema path.

Files:

- `deck-schema.json` - source schema with editable text, cards, lines, and layout positions.
- `html-to-editable-ppt-demo.pptx` - generated editable PowerPoint deck.
- `qa/contact.png` - rendered contact sheet used for visual QA.

This demo was also opened in Microsoft PowerPoint for macOS and checked with real app screenshots. The PowerPoint check is important because native Office text wrapping can differ from LibreOffice/PDF rendering.

Regenerate the deck:

```bash
python scripts/html_to_editable_ppt.py schema-to-pptx \
  --schema examples/html-to-editable-ppt-demo/deck-schema.json \
  --output examples/html-to-editable-ppt-demo/html-to-editable-ppt-demo.pptx
```

Render and QA:

```bash
python scripts/html_to_editable_ppt.py render-pptx \
  --pptx examples/html-to-editable-ppt-demo/html-to-editable-ppt-demo.pptx \
  --out-dir examples/html-to-editable-ppt-demo/qa

python scripts/html_to_editable_ppt.py qa \
  --render-dir examples/html-to-editable-ppt-demo/qa \
  --contact-sheet examples/html-to-editable-ppt-demo/qa/contact.png
```
