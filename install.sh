#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/JerryLiu-uestc/deck-forge-harness.git"
ARCHIVE_URL="https://github.com/JerryLiu-uestc/deck-forge-harness/archive/refs/heads/main.zip"
PLUGIN_NAME="deck-forge-harness"
PLUGIN_DIR="${HOME}/plugins/${PLUGIN_NAME}"
MARKETPLACE="${HOME}/.agents/plugins/marketplace.json"

echo "Installing ${PLUGIN_NAME}..."

mkdir -p "${HOME}/plugins" "${HOME}/.agents/plugins"

if command -v git >/dev/null 2>&1; then
  if [ -d "${PLUGIN_DIR}/.git" ]; then
    git -C "${PLUGIN_DIR}" pull --ff-only
  else
    rm -rf "${PLUGIN_DIR}"
    git clone "${REPO_URL}" "${PLUGIN_DIR}"
  fi
else
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' EXIT
  if ! command -v curl >/dev/null 2>&1 || ! command -v unzip >/dev/null 2>&1; then
    echo "git is not installed, and curl/unzip fallback is unavailable." >&2
    exit 1
  fi
  curl -fsSL "${ARCHIVE_URL}" -o "${tmp_dir}/${PLUGIN_NAME}.zip"
  unzip -q "${tmp_dir}/${PLUGIN_NAME}.zip" -d "${tmp_dir}"
  rm -rf "${PLUGIN_DIR}"
  mv "${tmp_dir}/${PLUGIN_NAME}-main" "${PLUGIN_DIR}"
fi

chmod +x "${PLUGIN_DIR}/scripts/deckforge.py"

python3 -m pip install --user --quiet python-pptx pillow || {
  echo "Python dependency install failed. Try: python3 -m pip install python-pptx pillow" >&2
  exit 1
}

need_soffice=0
need_poppler=0
command -v soffice >/dev/null 2>&1 || command -v libreoffice >/dev/null 2>&1 || need_soffice=1
command -v pdftoppm >/dev/null 2>&1 || need_poppler=1

if [ "${need_soffice}" -eq 1 ] || [ "${need_poppler}" -eq 1 ]; then
  case "$(uname -s)" in
    Darwin)
      if command -v brew >/dev/null 2>&1; then
        [ "${need_soffice}" -eq 0 ] || brew install --cask libreoffice
        [ "${need_poppler}" -eq 0 ] || brew install poppler
      else
        echo "Homebrew not found. Install LibreOffice and Poppler manually for render QA." >&2
      fi
      ;;
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y libreoffice poppler-utils
      else
        echo "apt-get not found. Install LibreOffice and Poppler manually for render QA." >&2
      fi
      ;;
    *)
      echo "Skipping native render dependency install on this platform." >&2
      ;;
  esac
fi

python3 - "${MARKETPLACE}" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1]).expanduser()
path.parent.mkdir(parents=True, exist_ok=True)
if path.exists():
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        data = {}
else:
    data = {}

data.setdefault("name", "personal")
data.setdefault("interface", {"displayName": "Personal"})
plugins = data.setdefault("plugins", [])
entry = {
    "name": "deck-forge-harness",
    "source": {"source": "local", "path": "./plugins/deck-forge-harness"},
    "policy": {"installation": "AVAILABLE", "authentication": "ON_INSTALL"},
    "category": "Productivity",
}
plugins[:] = [p for p in plugins if p.get("name") != entry["name"]]
plugins.append(entry)
path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(path)
PY

echo
echo "Installed plugin at: ${PLUGIN_DIR}"
echo "Registered marketplace: ${MARKETPLACE}"
echo
"${PLUGIN_DIR}/scripts/deckforge.py" doctor || true
echo
echo "Next: restart Codex or refresh plugins, then enable DeckForge Harness from the Personal marketplace."
