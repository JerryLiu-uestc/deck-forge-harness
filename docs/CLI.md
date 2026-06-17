# DeckForge CLI Reference

Most users only need to enable the Codex plugin. This page is for manual CLI use and troubleshooting.

## Commands

Initialize a workspace:

```bash
python3 scripts/deckforge.py init --project deckforge
```

Check available Office/render backends:

```bash
python3 scripts/deckforge.py doctor
```

Render HTML slide canvases to PNG:

```bash
python3 scripts/deckforge.py html-to-png \
  --html deckforge/slides/index.html \
  --out-dir deckforge/renders
```

Assemble rendered images into PPTX:

```bash
python3 scripts/deckforge.py images-to-pptx \
  --input-dir deckforge/renders \
  --output deckforge/pptx/deck.pptx
```

Build editable PPTX from JSON element schema:

```bash
python3 scripts/deckforge.py schema-to-pptx \
  --schema deckforge/harness/deck-schema.json \
  --output deckforge/pptx/deck.pptx
```

Render PPTX previews:

```bash
python3 scripts/deckforge.py render-pptx \
  --pptx deckforge/pptx/deck.pptx \
  --out-dir deckforge/qa
```

Run basic preview QA:

```bash
python3 scripts/deckforge.py qa \
  --render-dir deckforge/qa \
  --contact-sheet deckforge/qa/contact.png
```

## One-Slide Smoke Test

```bash
mkdir -p /tmp/deckforge-smoke
cat > /tmp/deckforge-smoke/deck-schema.json <<'JSON'
{
  "canvas": {"w": 1280, "h": 720},
  "slides": [
    {
      "background": "#FFFFFF",
      "elements": [
        {"type": "text", "x": 80, "y": 70, "w": 980, "h": 90, "text": "DeckForge is ready", "fs": 44, "bold": true, "color": "#0F766E"},
        {"type": "card", "x": 80, "y": 190, "w": 460, "h": 180, "fill": "#ECFDF5", "line": "#99F6E4"},
        {"type": "text", "x": 110, "y": 230, "w": 400, "h": 80, "text": "Schema to editable PPTX", "fs": 26, "bold": true, "color": "#134E4A"}
      ]
    }
  ]
}
JSON

python3 scripts/deckforge.py schema-to-pptx \
  --schema /tmp/deckforge-smoke/deck-schema.json \
  --output /tmp/deckforge-smoke/deck.pptx

python3 scripts/deckforge.py render-pptx \
  --pptx /tmp/deckforge-smoke/deck.pptx \
  --out-dir /tmp/deckforge-smoke/qa

python3 scripts/deckforge.py qa \
  --render-dir /tmp/deckforge-smoke/qa \
  --contact-sheet /tmp/deckforge-smoke/qa/contact.png
```
