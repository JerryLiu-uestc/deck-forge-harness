# DeckForge Harness

[中文说明](README-zh.md)

Codex plugin for building polished presentation decks from intake, web/browser capture, frontend slide design, harness automation, and PPTX export.

## Install

Run one command:

```bash
curl -fsSL https://raw.githubusercontent.com/JerryLiu-uestc/deck-forge-harness/main/install.sh | bash
```

Or download the repository ZIP from GitHub, unzip it, and run:

```bash
bash install.sh
```

Then restart Codex or refresh plugins, and enable **DeckForge Harness** from the **Personal** marketplace.

The installer downloads the plugin, installs Python dependencies, registers the Codex marketplace entry, and installs LibreOffice/Poppler when a supported package manager is available.

## Use

In Codex, ask:

```text
Use DeckForge to create a polished PPT from my materials.
```

DeckForge will ask for page count, title, audience, language, source scope, style direction, editability target, and quality reference before it starts making slides.

## What It Does

- Captures web/app material with Playwright, Browser tools, or local screenshots.
- Designs slides as frontend canvases before exporting to PPTX.
- Uses small harness adapters for repeatable local workflows.
- Builds PPTX with `python-pptx` and verifies renders with LibreOffice/Poppler.
- Supports a portable JSON element-router path for structured decks.

## Platform Notes

- macOS/Linux: uses `python-pptx` plus LibreOffice for export and QA.
- Windows: can optionally use WPS/MS Office COM when `pywin32` and Office are installed.
- WPS COM is not a macOS capability.

Manual CLI reference: [docs/CLI.md](docs/CLI.md)
