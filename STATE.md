# STATE.md — session 交接檔

最後更新:2026-08-04 / 任務:文件化 Claude × Antigravity 協作模式並驗證 COWORK 盤點

## 現況

repo 已有完整工作制度、尚無程式碼。制度檔案:`CLAUDE.md`(憲法 v1.2)、`docs/playbooks/`(五份)、`docs/decisions/`(ADR 0001–0003)、`docs/context/`(外部環境盤點含正確性驗證)、`.claude/skills/`(handoff、adr)、`todo.md`(待辦單一來源)。本 session 新增:`docs/context/cowork-inventory.md`(比對使用者的掃描報告後已更正 3 處錯誤)、`docs/context/claude-antigravity-collaboration.md`(4 大協作模式 + herdr 決策)。預設分支:`claude/fable5-system-design-jem9sn`。

## 進行中(含下一步)

- 無進行中的工作。下一個 session 從使用者的新任務開始;開工儀式照 CLAUDE.md 第 0 節。

## Backlog

- 見 `todo.md`(待辦單一來源,見 docs/decisions/0002;新發現的待辦寫進去,不寫在本檔)

## 地雷與教訓

- 2026-08-04 本 session 用**實務驗證**修正了初版盤點的 3 處錯誤（比對掃描報告 PROJECT_PROVENANCE_SCAN.md 與 COWORK_SCAN_FINAL.md）:OCR 位置、_Codex 後綴用途、PIC2PDF/CLIP 分類。這是「截圖 → 推論 → 被資料驗證糾正」的好案例；若下次使用者又貼截圖，先問「有沒有能讀到的原始掃描報告？」
- 2026-08-04 協作模式文件化時發現:使用者已在 C:\COWORK 實施 Watchdog 模式(AGY 監控 GPU)超過一個月。文件化時應主動問「現有實作有沒有漏掉的?」而非假設只有理論。
- 2026-08-02 使用者可能用**截圖**餵資料(例:檔案總管的搜尋結果)。截圖只給檔名與路徑,**不等於讀過內容**。這種輸入要照 ADR 0003 寫進 `docs/context/`,並在檔頭把「看到什麼/沒看到什麼/哪些是推論」分開寫清楚;直接把推論寫成事實會讓下一個 session 拿去改真的程式碼。另注意截圖常被視窗邊界裁切,清單未必完整,要在檔案裡註明。
- 2026-07-25 這個雲端 session 這陣子被使用者當成**跨專案的架構討論/記憶樞紐**在用(James 制度本身之外,還討論了 Windows 本機的 OCR pipeline、`mattpocock/skills` 安裝、Antigravity IDE 導入、`C:\ESH` 等專案)。**這些專案的原始碼都不在本 session 可存取範圍**(不同機器/不同 repo),任何關於它們的分析都只能基於使用者貼進對話的文字內容,不能宣稱讀過實際檔案。下一個 session 若被問起這些專案,先確認自己有沒有實際存取權,沒有就照鐵律 8 誠實說明,不要假裝已核實。
- 2026-07-18 **本 repo 任何含中文的 .ps1 檔,寫入時必須帶 UTF-8 BOM。** 原因:使用者在 Windows PowerShell 5.1(Windows 內建版本,非 pwsh 7)實跑 `continue-session.ps1` 時報錯 `函數參數清單中遺失 ')'`——PowerShell 5.1 對無 BOM 的 .ps1 用系統 ANSI codepage(繁中 Windows 常是 Big5)解碼,腳本裡的中文註解被錯誤解碼,連帶讓引號/括號解析錯位。用 Python 補 `\xef\xbb\xbf` 開頭即修復。往後在本 repo 寫/改任何 .ps1、且內容含非 ASCII 字元時,寫完要檢查:`file <腳本>` 應顯示「with BOM」;沒有就補。
- 2026-07-06 子代理的回報也適用鐵律 2:代理宣稱完成後,主 session 仍須親自用 `git log` / `git diff --stat` / `git ls-remote` 核實,不能只信自述。
- 2026-07-06 任何「平台應該會自動…」的假設(例:GitHub 把首推分支設為預設)都有一行指令可實測(`git ls-remote --symref origin HEAD`),先測再宣稱。
- 2026-07-04 本環境是暫時容器,session 結束就回收——**任何沒 push 的工作等於消失**,收工必 push。
- 2026-07-04 這個 repo 由不同等級的模型輪流接手。交接品質決定一切:更新本檔時,以「下一個 session 不重複我的探索就能直接接手」為驗收標準。
