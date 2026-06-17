# DeckForge CLI 参考

大多数用户只需要运行 `install.sh` 并在 Codex 中启用插件。本页用于手动调用 CLI 和排查问题。

## 命令

初始化工作区：

```bash
python3 scripts/deckforge.py init --project deckforge
```

检查当前机器可用的 Office / 渲染后端：

```bash
python3 scripts/deckforge.py doctor
```

将 HTML 幻灯片画布渲染为 PNG：

```bash
python3 scripts/deckforge.py html-to-png \
  --html deckforge/slides/index.html \
  --out-dir deckforge/renders
```

将渲染出的图片拼装为 PPTX：

```bash
python3 scripts/deckforge.py images-to-pptx \
  --input-dir deckforge/renders \
  --output deckforge/pptx/deck.pptx
```

用 JSON 元素路由生成可编辑 PPTX：

```bash
python3 scripts/deckforge.py schema-to-pptx \
  --schema deckforge/harness/deck-schema.json \
  --output deckforge/pptx/deck.pptx
```

将 PPTX 渲染为预览图：

```bash
python3 scripts/deckforge.py render-pptx \
  --pptx deckforge/pptx/deck.pptx \
  --out-dir deckforge/qa
```

运行基础预览 QA：

```bash
python3 scripts/deckforge.py qa \
  --render-dir deckforge/qa \
  --contact-sheet deckforge/qa/contact.png
```

## 一页冒烟测试

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
