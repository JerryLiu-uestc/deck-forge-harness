# Installation

1. Download the repository ZIP from GitHub.
2. Unzip it.
3. Move the folder to a local plugin location, for example:

```text
~/plugins/deck-forge-harness
```

4. Open Codex, refresh plugins, and enable **DeckForge Harness** from the local/personal marketplace.

If your Codex setup does not automatically discover `~/plugins`, add this plugin to your personal marketplace entry. The expected plugin path is:

```text
./plugins/deck-forge-harness
```

## Optional Runtime Dependencies

DeckForge can be enabled as a plugin without running a shell installer. Some local harness features need external tools:

- `python-pptx` and Pillow for PPTX generation;
- LibreOffice and Poppler for PPTX render QA;
- Node.js and Playwright for HTML/browser capture.

If these are missing, DeckForge should report the missing capability and use the best available fallback.
