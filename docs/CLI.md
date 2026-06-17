# HTML to Editable PPT CLI Reference

Most users only need to enable the Codex plugin. This page is for manual CLI use and troubleshooting.

## Commands

Initialize a workspace:

```bash
python3 scripts/html_to_editable_ppt.py init --project editable-ppt
```

Check available Office/render backends:

```bash
python3 scripts/html_to_editable_ppt.py doctor
```

Render HTML slide canvases to PNG:

```bash
python3 scripts/html_to_editable_ppt.py html-to-png \
  --html editable-ppt/slides/index.html \
  --out-dir editable-ppt/renders
```

Assemble rendered images into PPTX:

```bash
python3 scripts/html_to_editable_ppt.py images-to-pptx \
  --input-dir editable-ppt/renders \
  --output editable-ppt/pptx/deck.pptx
```

Build editable PPTX from JSON element schema:

```bash
python3 scripts/html_to_editable_ppt.py schema-to-pptx \
  --schema editable-ppt/harness/deck-schema.json \
  --output editable-ppt/pptx/deck.pptx
```

Render PPTX previews:

```bash
python3 scripts/html_to_editable_ppt.py render-pptx \
  --pptx editable-ppt/pptx/deck.pptx \
  --out-dir editable-ppt/qa
```

Run basic preview QA:

```bash
python3 scripts/html_to_editable_ppt.py qa \
  --render-dir editable-ppt/qa \
  --contact-sheet editable-ppt/qa/contact.png
```

## One-Slide Smoke Test

```bash
mkdir -p /tmp/html-to-editable-ppt-smoke
cat > /tmp/html-to-editable-ppt-smoke/deck-schema.json <<'JSON'
{
  "canvas": {"w": 1280, "h": 720},
  "slides": [
    {
      "background": "#FFFFFF",
      "elements": [
        {"type": "text", "x": 80, "y": 70, "w": 980, "h": 90, "text": "HTML to Editable PPT is ready", "fs": 44, "bold": true, "color": "#0F766E"},
        {"type": "card", "x": 80, "y": 190, "w": 460, "h": 180, "fill": "#ECFDF5", "line": "#99F6E4"},
        {"type": "text", "x": 110, "y": 230, "w": 400, "h": 80, "text": "Schema to editable PPTX", "fs": 26, "bold": true, "color": "#134E4A"}
      ]
    }
  ]
}
JSON

python3 scripts/html_to_editable_ppt.py schema-to-pptx \
  --schema /tmp/html-to-editable-ppt-smoke/deck-schema.json \
  --output /tmp/html-to-editable-ppt-smoke/deck.pptx

python3 scripts/html_to_editable_ppt.py render-pptx \
  --pptx /tmp/html-to-editable-ppt-smoke/deck.pptx \
  --out-dir /tmp/html-to-editable-ppt-smoke/qa

python3 scripts/html_to_editable_ppt.py qa \
  --render-dir /tmp/html-to-editable-ppt-smoke/qa \
  --contact-sheet /tmp/html-to-editable-ppt-smoke/qa/contact.png
```
