# 用途:找出「CMD 視窗三不五時自己跳出來」的元兇。
#       依序列出：會執行 cmd/命令列的排程任務、登入啟動項、開機啟動資料夾。
#       CMD 視窗閃現九成來自「工作排程器」的排程任務,少數來自登入啟動項。
#
# 用法(以系統管理員身分開 PowerShell,較完整;一般身分也能跑,只是看不到部分系統排程):
#   powershell -ExecutionPolicy Bypass -File diagnose-cmd-popup.ps1
#
# 跑完把整段輸出複製貼給 AI session 分析即可,不需要你自己看懂。

$ErrorActionPreference = 'Continue'

Write-Host '========== 1. 排程任務(依「上次執行時間」由近到遠排序,最可能是兇手)==========' -ForegroundColor Cyan
$tasks = Get-ScheduledTask | Where-Object { $_.State -ne 'Disabled' }
$rows = foreach ($t in $tasks) {
    $info = Get-ScheduledTaskInfo -TaskName $t.TaskName -TaskPath $t.TaskPath -ErrorAction SilentlyContinue
    $actions = ($t.Actions | ForEach-Object { "$($_.Execute) $($_.Arguments)" }) -join ' | '
    [PSCustomObject]@{
        任務名稱   = $t.TaskName
        路徑       = $t.TaskPath
        狀態       = $t.State
        上次執行   = $info.LastRunTime
        下次執行   = $info.NextRunTime
        上次結果   = $info.LastTaskResult
        執行內容   = $actions
    }
}
$rows | Sort-Object 上次執行 -Descending | Format-Table -AutoSize -Wrap

Write-Host ''
Write-Host '========== 2. 特別標註:內容含 cmd.exe / .bat / .cmd / wscript 的排程任務(嫌疑最高) ==========' -ForegroundColor Yellow
$rows | Where-Object { $_.執行內容 -match 'cmd\.exe|\.bat|\.cmd|wscript|cscript' } |
    Format-Table 任務名稱, 路徑, 上次執行, 下次執行, 執行內容 -AutoSize -Wrap

Write-Host ''
Write-Host '========== 3. 登入啟動項(登入 Windows 時自動執行) ==========' -ForegroundColor Cyan
Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location, User | Format-Table -AutoSize -Wrap

Write-Host ''
Write-Host '========== 4. 開機啟動資料夾內容 ==========' -ForegroundColor Cyan
$startupFolders = @(
    [Environment]::GetFolderPath('Startup'),
    [Environment]::GetFolderPath('CommonStartup')
)
foreach ($f in $startupFolders) {
    Write-Host "-- $f --"
    if (Test-Path $f) { Get-ChildItem $f -Force | Select-Object Name, LastWriteTime } else { Write-Host '(不存在)' }
}

Write-Host ''
Write-Host '完成。把以上整段輸出複製貼給 AI session,重點看第 2 段(最可能是兇手)與第 1 段裡「上次執行時間」接近你看到 CMD 跳出來那一刻的項目。' -ForegroundColor Green
