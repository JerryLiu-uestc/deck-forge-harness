# 安装说明

## 下载

从 GitHub 下载 ZIP：

```text
https://github.com/JerryLiu-uestc/deck-forge-harness/archive/refs/heads/main.zip
```

如果你希望后续用 Git 更新，也可以 clone：

```bash
git clone https://github.com/JerryLiu-uestc/deck-forge-harness ~/plugins/deck-forge-harness
```

## 在 Codex 中启用

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

## 让 Codex 帮你安装

把下面这段话复制给 Codex：

```text
请帮我安装这个 Codex 插件：https://github.com/JerryLiu-uestc/deck-forge-harness。
请使用安全的本地插件安装流程：下载或 clone 仓库，放到 ~/plugins/deck-forge-harness，必要时注册到我的个人 Codex marketplace，然后运行插件校验。不要运行远程 shell 安装命令。
安装后请告诉我如何在 Codex 里启用 DeckForge Harness，并检查我当前系统是否缺少可选运行依赖。
```

## 按平台配置可选运行依赖

DeckForge 可以作为插件直接启用，不需要运行 shell 安装脚本。部分本地 harness 功能需要额外工具：

- `python-pptx` 和 Pillow，用于生成 PPTX；
- LibreOffice 和 Poppler，用于渲染 QA；
- Node.js 和 Playwright，用于 HTML / 浏览器采集。

macOS：

```bash
brew install --cask libreoffice
brew install poppler
python3 -m pip install python-pptx pillow
```

Linux：

```bash
sudo apt-get install libreoffice poppler-utils
python3 -m pip install python-pptx pillow
```

Windows：

```powershell
py -m pip install python-pptx pillow pywin32
```

Windows 上使用 WPS/MS Office COM 自动化还需要安装 WPS Office 或 Microsoft Office。macOS 不支持 WPS COM。

如果缺少这些工具，DeckForge 应该报告缺失能力，并使用当前可用的最佳兜底路径。
