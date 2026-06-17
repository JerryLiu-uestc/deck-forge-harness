# HTML to Editable PPT CLI 参考

大多数用户只需要在 Codex 中启用插件。本页用于手动调用 CLI 和排查问题。

## 命令

初始化工作区：

```bash
python3 scripts/html_to_editable_ppt.py init --project editable-ppt
```

检查当前机器可用的 Office / 渲染后端：

```bash
python3 scripts/html_to_editable_ppt.py doctor
```

将 HTML 幻灯片画布渲染为 PNG：

```bash
python3 scripts/html_to_editable_ppt.py html-to-png \
  --html editable-ppt/slides/index.html \
  --out-dir editable-ppt/renders
```

将渲染出的图片拼装为 PPTX：

```bash
python3 scripts/html_to_editable_ppt.py images-to-pptx \
  --input-dir editable-ppt/renders \
  --output editable-ppt/pptx/deck.pptx
```

用 JSON 元素路由生成可编辑 PPTX：

```bash
python3 scripts/html_to_editable_ppt.py schema-to-pptx \
  --schema editable-ppt/harness/deck-schema.json \
  --output editable-ppt/pptx/deck.pptx
```

将 PPTX 渲染为预览图：

```bash
python3 scripts/html_to_editable_ppt.py render-pptx \
  --pptx editable-ppt/pptx/deck.pptx \
  --out-dir editable-ppt/qa
```

运行基础预览 QA：

```bash
python3 scripts/html_to_editable_ppt.py qa \
  --render-dir editable-ppt/qa \
  --contact-sheet editable-ppt/qa/contact.png
```

## 一页冒烟测试

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
