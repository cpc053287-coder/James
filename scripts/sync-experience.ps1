# 用途:把本 repo 的經驗紀錄檔同步到 C:\COWORK\Experience
# 用法:在 repo 目錄下執行
#   powershell -ExecutionPolicy Bypass -File scripts\sync-experience.ps1
# 可重複執行:每次會先 git pull 取最新,再覆蓋目的地的同名檔。
# 注意:本腳本撰寫於無 PowerShell 的 Linux 環境,尚未在 Windows 實機驗證;
#       第一次執行請確認輸出無紅字。

$ErrorActionPreference = 'Stop'
$dest = 'C:\COWORK\Experience'

git pull

New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Path 'STATE.md', 'todo.md' -Destination $dest -Force

$destDecisions = Join-Path $dest 'decisions'
New-Item -ItemType Directory -Force -Path $destDecisions | Out-Null
Copy-Item -Path 'docs\decisions\*.md' -Destination $destDecisions -Force

Write-Host "已同步 STATE.md、todo.md、docs/decisions/*.md → $dest"
