# C:\COWORK 專案盤點

最後更新:2026-08-02

## 資料來源與可信度界線(先讀這段)

本檔混合三種來源,**可信度不同,已逐項標示**:

| 代號 | 來源 | 本 session 實際做了什麼 |
|---|---|---|
| **[掃描]** | 使用者的 `C:\COWORK\PROJECT_PROVENANCE_SCAN.md`、`COWORK_SCAN_FINAL.md`(掃描日 2026-08-01) | **已完整讀過全文**。內容是使用者在本機跑 metadata 掃描的結果 |
| **[截圖]** | 使用者提供的檔案總管搜尋截圖(`C:\COWORK\*.md`,2026-08-02) | 只看到**檔名與路徑**,沒有內容;截圖底部疑似被視窗裁切,未必完整 |
| **[推論]** | 本 session 從上述兩者推出的判斷 | 未經證實 |

**本 session 從未讀過任何一個專案的原始碼。** `C:\COWORK` 在使用者的 Windows 本機,
雲端 session 無存取權。要根據程式**內容**做事,必須先請使用者貼上,或推到讀得到的 repo。

兩份掃描本身也有自陳限制:「基於 metadata 掃描,未逐一驗證程式依賴關係、檔案內容或執行狀態」。

## 最重要的三件事

1. **整個 `C:\COWORK` 沒有可用的版本控制。** `.git` 存在但追蹤 0 個檔案,
   無法 `git blame`。唯一有真實 commit 歷史的是 `ComfyUI`,而那是上游社群專案。
   後果:多數專案的「誰改的、什麼時候改的」**永久無法還原**,只能靠 `LastWriteTime` 推定。[掃描]

2. **`_Codex` 後綴是全樹唯一有效的作者標記慣例。**
   `stage1_Codex.py`、`NotebookLM_GUI_Codex.py`、`啟動_GUI_Codex.bat`、`開發交接紀錄_Codex.md`
   ——這是唯一能「確定」作者的機制。不要把它當成命名混亂去「統一」掉。[掃描]

3. **已標記存在的敏感設定檔**(掃描報告未揭露內容,僅標記):
   `mail_config.json`、`rclone.conf`、多個 `config.json`、`.claude/settings.local.json`、
   `備用碼.txt`、`esh_watch_crawler/config.yaml`、`config_other_orgs.yaml`。
   由於 git 追蹤 0 檔,`.gitignore` 的保護**從未被實際驗證過**。[掃描]

## 專案清單

規模數字來自 `COWORK_SCAN_FINAL.md`;作者欄來自 `PROJECT_PROVENANCE_SCAN.md`。

| 專案 | 規模 | 最後版作者 | 備註 |
|---|---|---|---|
| `CLIP` | 104.5 GB / 1906 檔 | 不明 | 短影音專案,最早素材 2023-09-25 |
| `ComfyUI` | 36.1 GB / 61096 檔 | Alexander Piskun(**確定**,上游 commit) | **上游社群專案,非使用者自製**;HEAD `83082a51` |
| `ollama_models` | 30.7 GB | — | 本地 LLM 模型倉庫,非專案 |
| `FAMILY_VIDEO_EDITOR` | 10.6 GB / 2438 檔 | 不明 | 影片編輯 |
| `Qwythos` | 8.3 GB | Empero AI(**確定**,上游) | 模型,非使用者自製 |
| `HEAT_CAPTURES` | 7.5 GB / 22159 檔 | — | 熱危害截圖,已萃出 `HEAT_CSV` |
| `PIC2PDF` | 3.9 GB / 1746 檔 | 不明 | 照片轉 PDF |
| `OCR` | 3.1 GB / 7569 檔 | 不明(Claude 參與維護可推定) | **在 COWORK 底下**,非獨立位置 |
| `PPT` / `NotebookLM` | 2.6 GB / 476 檔 | **ChatGPT Codex(確定)** | `_Codex` 命名版為最新;無後綴初版作者不明 |
| `REPORT` | 0.41 GB / 702 檔 | 不明 | 468 份 Markdown 報告,多為產物 |
| `POWERPOINT` | — | Claude + Antigravity(高度推定) | README 明載 `Step 3 (Claude/Antigravity)` |
| `LAW_RAG` | — | 不明 | 法規 + LightRAG 產物 |
| `ACCOUNTING` | 252 MB | 不明 | |
| `CALCULATOR` | — | 不明 | 有 v1 備份與 v2 說明 |
| `FTA_MCS_UI` | — | 不明 | 最新為 `FTA_MCS_單檔版.html` |
| `Geothermal` | 173 MB | 不明 | |
| `CLAUDE_ENV_BUNDLE` | — | Claude 環境整理(高度推定) | |
| `advisor策略` | — | Claude/Sonnet(推定) | 文件明載分工,非 commit 紀錄 |
| `any2md` / `ConvertALL` | — | 不明 | 格式轉換,含 `.spec` 與 GUI |
| `工安新聞` / HSE news | — | 自動排程產出 | 執行者 ≠ 程式製作者 |
| `esh_patch_stage` | — | ChatGPT Codex(高度推定) | 屬 ESH patch staging,非獨立產品 |
| **`PKM`** | 掃描中**不存在** | — | **見下節** |

非專案項目(資料/環境/中間物,掃描報告明載不虛構作者):
`SPEND`、`SPLIT_UP_DOWN`、`SPLIT_LEFT_RIGHT`、`esh_report_pages`、`lo_*_profile`、
`build`、`dist`、`.venv`、模型權重、測試輸出。

總計 228.5 GB / 183,594 個檔案與目錄(含 `C:\ESH` 的 0.35 GB)。

## PKM:新專案,兩份掃描都沒有

`PKM` 在 2026-08-01 的兩份掃描中**完全沒有出現**,但 2026-08-02 的截圖顯示它已有
ADR 0001–0004、`docs/debugging/`、5 種筆記範本、5 份詞彙表。
**[推論]** PKM 是 2026-08-02(截圖當天)才建立的全新專案,且一次就套用了完整制度架構。
其中 `2026-08-02-initial-hardening-lessons.md` 的日期即為當天。

PKM 的結構與本 repo(James)的制度同構(`docs/adr/` + `docs/debugging/` + `AGENTS.md`)。
從 ADR 檔名可知它已處理過兩個關鍵問題:
`0001-local-markdown-is-source-of-truth`、`0003-frontmatter-controls-cloud-boundary`(哪些筆記可上雲)。

**PKM 的內容一份都沒讀過**,以上全部來自檔名。[截圖]

PKM 目錄結構(截圖可見部分):
```
PKM\  README.md, CONTEXT.md, AGENTS.md, PKM_規劃書.md, 筆記格式規範.md
 ├ docs\adr\        0001-local-markdown-is-source-of-truth / 0002-two-layer-note-lifecycle
 │                  0003-frontmatter-controls-cloud-boundary / 0004-separate-version-history-from-disaster-recovery
 ├ docs\debugging\  README.md / 2026-08-02-initial-hardening-lessons.md
 ├ _templates\      範本-隨手捕捉 / 資源筆記 / 領域筆記 / 專案筆記 / 錄音筆記
 └ 03-Resources\Glossary\  人名 / 公司與單位 / 專案名稱 / 技術名詞 / 台語與常見誤辨詞
```

## 更正紀錄(2026-08-02,本檔初版的錯誤)

本檔初版僅憑截圖建立,經與使用者的兩份掃描比對後更正如下。保留此節是為了讓後續 session
知道「只憑檔名推論」會錯到什麼程度:

| 初版寫的 | 更正 |
|---|---|
| COWORK 底下有 7 個專案 | **錯,嚴重不完整**。實際約 21 個。截圖只搜 `.md`,漏掉所有無 .md 的專案 |
| 「OCR pipeline 不在 `C:\COWORK` 底下」 | **錯**。`OCR` 就是 COWORK 下的專案(3.1 GB / 7569 檔)。只有 `C:\ESH` 在外面 |
| 「交接檔命名不統一,`開發交接紀錄_Codex.md` 是例外」 | **講反了**。`_Codex` 後綴是刻意的作者標記,是全樹唯一可靠的 provenance 機制 |
| 「AI 指示檔命名不統一(CLAUDE.md vs AGENTS.md)」 | 觀察本身成立,但**沒抓到真正的問題**:整個 COWORK 沒有可用 git 歷史 |
| 「PKM 是最活躍的專案」 | **成立且更強**:掃描證明它 08-01 還不存在 |
| 「`C:\COWORK\todo.md` 與本 repo 的 todo.md 是兩份不同清單」 | **成立**。掃描顯示它是 08-01 16:10:55 最後更新的檔案 |
| `CLIP` 用途未知 | 已知:短影音專案 |

## 掃描報告提出、尚未落實的建議

`PROJECT_PROVENANCE_SCAN.md` §7 建議每個專案根目錄加 `PROVENANCE.md`,
每次 AI 修改追加「版本/時間/製作者/工作內容/基準檔/驗證/上一版」七欄;
並讓不同工具用可辨識的 git author。**尚未實施**(截圖中沒有任何 `PROVENANCE.md`)。

## 給下一個 session 的提醒

- 使用者提到上表任一專案時,先講清楚「我讀不到那個專案的程式碼」,再基於使用者貼上的內容作業。
- **不要憑本檔的規模數字做刪除決策。** 掃描自陳「未驗證程式依賴關係與執行狀態」,
  且資料已是 2026-08-01 的快照。任何清理都屬破壞性動作,須照憲法 1.1 先取得同意。
- 本檔的「更正紀錄」是活教材:只憑檔名清單推論專案全貌,錯誤率極高。
