# DeckForge Harness

[English README](README.md)

用于制作高质量 PPT / 演示文稿的 Codex 插件。它会先确认需求和视觉标准，再结合网页/浏览器采集、前端幻灯片设计、harness 自动化和 PPTX 导出完成交付。

## 安装

运行一个命令：

```bash
curl -fsSL https://raw.githubusercontent.com/JerryLiu-uestc/deck-forge-harness/main/install.sh | bash
```

或者在 GitHub 下载 ZIP，解压后运行：

```bash
bash install.sh
```

然后重启 Codex 或刷新插件列表，在 **Personal** marketplace 里启用 **DeckForge Harness**。

安装脚本会下载插件、安装 Python 依赖、注册 Codex marketplace，并在检测到可用包管理器时安装 LibreOffice / Poppler。

## 使用

在 Codex 里说：

```text
用 DeckForge 根据我的材料做一个好看的 PPT。
```

DeckForge 会先询问页数、标题、受众、语言、资料范围、风格方向、可编辑目标和质量参考，确认后才开始制作。

## 能做什么

- 用 Playwright、Browser 工具或本地截图采集网页/应用素材。
- 先用前端画布设计幻灯片，再导出为 PPTX。
- 用小型 harness 适配器封装可重复的本地流程。
- 用 `python-pptx` 生成 PPTX，并用 LibreOffice / Poppler 渲染检查。
- 支持 JSON 元素路由，适合结构化、数据驱动的 deck。

## 平台说明

- macOS/Linux：默认使用 `python-pptx` + LibreOffice 进行导出和 QA。
- Windows：安装 `pywin32` 和 WPS / Microsoft Office 后，可以选择 WPS/MS Office COM 后端。
- WPS COM 不是 macOS 能力。

手动 CLI 参考：[docs/CLI-zh.md](docs/CLI-zh.md)
