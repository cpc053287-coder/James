# 用途:Claude 5 小時額度重置後,自動對前景視窗送出「繼續」訊息,
#       讓留在全螢幕的 session(例:本地模型文字辨識OCR)接著跑。
#
# 用法(PowerShell,在任意目錄):
#   額度將於 14:30 重置:
#     powershell -ExecutionPolicy Bypass -File continue-session.ps1 -At "14:30"
#   或用「再過幾分鐘」指定:
#     powershell -ExecutionPolicy Bypass -File continue-session.ps1 -DelayMinutes 90
#   自訂送出的訊息:
#     ... -At "14:30" -Message "continue"
#
# 前置條件(缺一不可):
#   1. 目標 session 視窗保持在「前景」且輸入框可打字(你已全螢幕,符合)。
#   2. 螢幕不能自動鎖定:設定 → 帳戶 → 登入選項,或把「螢幕保護裝置」的
#      「繼續執行時,顯示登入畫面」取消。腳本會阻止睡眠,但擋不住密碼鎖。
#   3. 觸發時刻前後不要碰鍵盤滑鼠——訊息會送進「當時的前景視窗」。
#
# 停止:在本視窗按 Ctrl+C。
# 注意:本腳本撰寫於無 PowerShell 的環境,尚未實機驗證;首次使用建議先用
#       -DelayMinutes 1 對一個記事本視窗試跑一次,確認會貼字+Enter。

param(
    [string]$At,                 # 重置時刻,24 小時制 "HH:mm";已過則視為明天
    [int]$DelayMinutes = 0,      # 與 -At 擇一
    [string]$Message = '繼續',
    [int]$BufferSeconds = 90,    # 重置時刻後再多等的緩衝,避免整點時額度尚未真正恢復
    [string]$WindowTitle = ''    # 選填:視窗標題關鍵字,觸發前先嘗試切到該視窗
)

$ErrorActionPreference = 'Stop'

# 計算觸發時間
if ($At) {
    $target = [datetime]::ParseExact($At, 'HH:mm', $null)
    if ($target -lt (Get-Date)) { $target = $target.AddDays(1) }
} elseif ($DelayMinutes -gt 0) {
    $target = (Get-Date).AddMinutes($DelayMinutes)
} else {
    Write-Host '請指定 -At "HH:mm" 或 -DelayMinutes N'; exit 1
}
$target = $target.AddSeconds($BufferSeconds)

# 阻止系統睡眠與螢幕關閉(擋不住密碼鎖定,見檔頭前置條件 2)
Add-Type @'
using System.Runtime.InteropServices;
public static class Awake {
    [DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
}
'@
[void][Awake]::SetThreadExecutionState(0x80000000 -bor 0x00000001 -bor 0x00000002)

Write-Host ("預定觸發時間:{0:yyyy-MM-dd HH:mm:ss}(含 {1} 秒緩衝)" -f $target, $BufferSeconds)
Write-Host ("將送出訊息:{0}" -f $Message)
Write-Host '倒數期間請保持目標視窗在前景、螢幕不鎖定。Ctrl+C 可取消。'

while ((Get-Date) -lt $target) {
    $left = $target - (Get-Date)
    Write-Host ("`r剩餘 {0:hh\:mm\:ss} " -f $left) -NoNewline
    Start-Sleep -Seconds 10
}
Write-Host ''

# 選填:嘗試把指定標題的視窗帶到前景
if ($WindowTitle) {
    $shell = New-Object -ComObject WScript.Shell
    if (-not $shell.AppActivate($WindowTitle)) {
        Write-Host ("找不到標題含「{0}」的視窗,改送前景視窗。" -f $WindowTitle)
    }
    Start-Sleep -Seconds 2
}

# 用剪貼簿貼上中文訊息(避開輸入法/SendKeys 對非 ASCII 的問題),再按 Enter
Set-Clipboard -Value $Message
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait('^v')
Start-Sleep -Milliseconds 800
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')

# 解除防睡眠
[void][Awake]::SetThreadExecutionState(0x80000000)
Write-Host ("已於 {0:HH:mm:ss} 送出訊息並按下 Enter。請確認 session 已繼續執行。" -f (Get-Date))
