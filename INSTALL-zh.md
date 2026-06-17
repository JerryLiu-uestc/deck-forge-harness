# 安装说明

1. 在 GitHub 下载本仓库 ZIP。
2. 解压。
3. 将文件夹移动到本地插件目录，例如：

```text
~/plugins/deck-forge-harness
```

4. 打开 Codex，刷新插件列表，并在本地/个人 marketplace 中启用 **DeckForge Harness**。

如果你的 Codex 没有自动发现 `~/plugins`，请把插件加入个人 marketplace。期望插件路径是：

```text
./plugins/deck-forge-harness
```

## 可选运行依赖

DeckForge 可以作为插件直接启用，不需要运行 shell 安装脚本。部分本地 harness 功能需要额外工具：

- `python-pptx` 和 Pillow，用于生成 PPTX；
- LibreOffice 和 Poppler，用于渲染 QA；
- Node.js 和 Playwright，用于 HTML / 浏览器采集。

如果缺少这些工具，DeckForge 应该报告缺失能力，并使用当前可用的最佳兜底路径。
