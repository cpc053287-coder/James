# Claude × Antigravity 協作模式指南

最後更新:2026-08-04
資料來源:使用者提供的 herdr.dev 研究與 C:\COWORK 實務經驗

## 這份檔案的用途

本 repo(James)是個人工作制度與交接檔的倉庫,尚無實際程式碼。但使用者在 Windows 本機
的多個專案(`C:\COWORK`、`C:\ESH` 等)已在使用 **Claude × Antigravity(Google 開發的協同助手)**
協作開發。本檔記錄這套協作模式,供後續涉及 Antigravity 的專案參考。

## 快速對比:herdr vs 邏輯協作

| 層面 | `herdr` | Claude × AGY 4 大模式 |
|---|---|---|
| **是什麼** | Rust 寫的終端 Agent 多工器(UI 工具) | 邏輯與任務的協作框架(已可運作) |
| **用途** | 在單一視窗切分頁顯示多個 Agent 的即時輸出 | 兩個智能體分工協作,達成複雜任務 |
| **必需性** | 可選(錦上添花) | 必需(已在 C:\COWORK 運作) |

**結論**:不需要 `herdr` 即可完美協作。herdr 純粹是「終端 UI 提升」,若喜歡在同一視窗管理多 Agent,再裝。

---

## Claude × Antigravity 4 大協作模式

### 1️⃣ 雙工接力 / 自動 Watchdog 模式 (Overnight Relay)

**狀態**: ✅ 已在 `C:\COWORK` 運作

**核心分工**:
- **Claude**: 寫程式、邏輯設計、程式碼重構
- **Antigravity(AGY)**: 盯控背景進程、排程、系統監控、自動續跑

**運作細節**:
1. Claude 執行極長時間任務(批次 OCR、巨型 Codebase 重構)時,遇上 5 小時額度限制或卡住
2. AGY 自動接管背景監控
3. AGY 執行 GPU 健檢(`ollama_gpu_watchdog.py`),防止殭屍進程佔用 VRAM
4. AGY 設定 `schedule` 定時器,於冷卻時間(如凌晨 02:30)自動醒來
5. 驗證環境無誤,指引 Claude 恢復並續跑
6. Claude 重新上線後直接按上次中斷點繼續

**應用場景**: OCR pipeline、大規模資料轉換、長時間爬蟲

**已知工具**:
- `ollama_gpu_watchdog.py`(GPU 監控)
- `continue-session.ps1`(自動續跑指令)

---

### 2️⃣ 主架構師 + 執行/測試員 (Architect & Runner/Tester)

**狀態**: 💡 可在新專案採用

**核心分工**:
- **Claude (Architect)**: 高階邏輯設計、TDD 測試設計、程式碼架構
  - 例:設計 `CandidateGate` 門閥、Map-Reduce 快取架構、驗證協議
- **AGY (Runner)**: 實際執行長時測試、部署、系統硬體監控
  - 例:執行完整 `pytest` Suite、監控 CPU/GPU 負載、回傳無裁切的 Log

**運作流程**:
```
Claude 設計測試與架構
   ↓
Claude 寫初版實裝代碼
   ↓
Claude 指派測試任務給 AGY
   ↓
AGY 執行 pytest 並回傳完整 Log / 硬體監控數據
   ↓
Claude 根據測試結果修正
   ↓
(重複)
```

**優勢**: Claude 專注邏輯,AGY 專注執行與監控,兩者各擅其場

---

### 3️⃣ Advisor 獨立審查模式 (Independent Advisory Review)

**狀態**: 💡 符合 James repo 的制度(破壞性動作前必審查)

**核心分工**:
- **Claude**: 遇到連續失敗、重大架構抉擇、或要進行破壞性改動時,整理「自包含簡報」
- **AGY (Advisor)**: 獨立進行程式碼審查、硬體相容性評估、方案選型,提供客觀解法

**運作流程**:
```
Claude 遇二次失敗或面臨破壞性改動
   ↓
Claude 依 CLAUDE.md 第 2.3 節準備自包含簡報
   (包括:失敗情景、已試過的方案、系統配置、預期代價)
   ↓
AGY 獨立審查代碼、評估硬體限制(例:GPU VRAM、Vulkan SSM op 缺失)
   ↓
AGY 提供客觀解法與選型建議
   (例:發現 Arc GPU 因 SSM op 缺失崩潰 → 轉往 SYCL 或 Ollama 方案)
   ↓
Claude 根據建議修正,避免盲點
```

**應用場景**:
- 遇到 CLAUDE.md 第 2.3 節的「同一問題失敗兩次」時
- 考慮更換技術棧、架構大改、或刪除大量代碼前
- 硬體診斷與相容性決策

**既有範例**:
- `C:\COWORK\docs/context/claude-antigravity-collaboration_report.md` (v2.2,Claude × AGY 協作規範)
- `C:\ESH\esh_watch_crawler` 的 Codex 交接紀錄(雖然當時未同時用 AGY 審查,但示範了「Advisor」的價值)

---

### 4️⃣ 檔案系統黑板模式 (File-based Task Handoff)

**狀態**: ✅ 已在本 repo 實施(STATE.md + todo.md)

**核心分工**:
- **Claude & AGY**: 不透過網路通訊,而是透過共享目錄的 Markdown / JSON 檔案進行任務交接
- **黑板檔案**:
  - `todo.md`:待辦事項、優先順序
  - `STATE.md`:上一個 session 的狀態快照
  - `memory/*.md`:工作紀錄、學習日誌
  - `*.json`:結構化資料(如 `PROJECT_STATE.json`、`collaboration_log.jsonl`)

**運作流程**:
```
Claude 完成某一階段產出
   (例:生成 Blocks_Index.md、修正 bug、完成重構)
   ↓
Claude 更新 todo.md / STATE.md / 相關文件
   ↓
Claude 提交 commit 並 push
   ↓
AGY 讀取新檔案與 commit log
   ↓
AGY 接續執行後續任務
   (例:打包 pyinstaller、排程維護、批次轉檔、GPU 監控)
   ↓
AGY 更新 `collaboration_log.jsonl` 與相關產出
   ↓
(下一個 Claude session 讀取 STATE.md / log 繼續)
```

**優勢**:
- 不需要複雜的 Socket / API 通訊
- Git 歷史即協作紀錄
- 非同步運作(Claude 改檔→提交→下線; AGY 讀檔→執行→記錄)
- 後續人類或其他 Agent 可輕易追蹤

**已在運作的例子**:
- 本 repo: `STATE.md` ← → 下一個 session
- `C:\COWORK`:根目錄 `todo.md`、各專案的 `README.md` / `DEVELOPMENT_HANDOFF.md`
- `C:\ESH\esh_watch_crawler`: `PROJECT_STATE.json` (Codex 修正的紀錄)

---

## 模式搭配建議

### 新專案啟動

```
✅ 用模式 4(黑板):建立 todo.md / README.md / 初版架構
   ↓
✅ 用模式 2(架構師+測試員):Claude 設計,AGY 執行測試與監控
   ↓
❌ 遇二次失敗?✅ 用模式 3(Advisor):AGY 獨立審查
   ↓
✅ 長時任務?✅ 加模式 1(Watchdog):AGY 背景接力
```

### 已有 Claude 專案,要加入 AGY

1. **評估工作性質**:
   - 純邏輯設計 → 模式 2(架構師+測試員)
   - 長時批處理 → 模式 1(Watchdog) + 模式 4(黑板)
   - 卡住了 → 模式 3(Advisor 審查)

2. **建立黑板檔案**(模式 4):
   - `todo.md` / `STATE.md` / `PROJECT_STATE.json`
   - 記錄 AGY 要接手的任務

3. **定義交接檢查點**(模式 4):
   - Claude 完成哪些里程碑後提交
   - AGY 要讀哪些檔案、執行哪些指令
   - 把結果寫回哪個檔案

---

## 對比:Claude × Codex vs Claude × Antigravity

### ChatGPT Codex 合作模式(已在 C:\ESH\esh_watch_crawler 實施)

| 項目 | Codex |
|---|---|
| **定位** | 代碼生成專家;會寫 Python、SQL、API 呼叫 |
| **強項** | 快速原型、API 集成、SQL 優化 |
| **弱項** | 系統級操作、背景排程、硬體監控、非代碼型決策 |
| **運作** | 同步(Claude 指派 → Codex 生成 → Claude 驗證) |

### Antigravity 合作模式(新)

| 項目 | Antigravity |
|---|---|
| **定位** | 系統級協同助手;能做系統呼叫、背景排程、子 Agent 派發 |
| **強項** | 長時任務監控、硬體診斷、系統權限操作、非同步排程 |
| **弱項** | 不是代碼生成專家(需 Claude 或 Codex 設計架構) |
| **運作** | 非同步(Claude 寫檔 → AGY 讀檔執行 → 回傳結果) |

**混合策略**:
- **Claude 寫架構與測試**
- **Codex 生成實裝代碼**(需要快速原型或 API 集成時)
- **Antigravity 執行測試、監控、排程、和硬體診斷**(需要系統級操作)

---

## 使用者現況

根據 `C:\COWORK\PROJECT_PROVENANCE_SCAN.md` §8:

| 專案 | Claude 角色 | Codex 角色 | AGY 角色 |
|---|---|---|---|
| `C:\ESH\esh_watch_crawler` | ✅ 初版設計 | ✅ **已接手**(P0/P1/P2 修正) | ⏳ 可加(Advisor 審查) |
| `C:\COWORK\POWERPOINT` | ✅ Step 3 設計 | ❌ 無 | ⏳ 可加(測試執行) |
| `C:\COWORK\OCR` | ✅ 維護中 | ❌ 無 | ✅ **已用**(GPU Watchdog) |

**結論**: Antigravity 的 Watchdog 與黑板模式已實際運作於 OCR pipeline;
其他協作模式與 Codex 混合策略可在下一輪專案中試驗。

---

## 後續行動

### herdr 安裝決策(2026-08-04)

**結論**: 選配(Optional)。

| 項目 | 決策 |
|---|---|
| **要不要裝** | 若習慣在終端機(PowerShell/CLI)直接執行 Agent 指令且需同時開多視窗 → ⭕ 裝;否則 ❌ 不必 |
| **裝在哪** | 全局系統工具,安裝一次後全電腦可用;不加進任何專案的 requirements.txt |
| **首選場景** | `C:\ESH\esh_watch_crawler`(Claude ↔ Codex 交接期間,用 herdr 同屏監控) |
| **次選場景** | `C:\COWORK`(長任務腳本與 Claude CLI 互動監控) |

**安裝(若決定裝)**:
```powershell
cargo install herdr
# 或直接下載編譯好的 herdr.exe 加入 PATH
```

**使用**:
```powershell
cd C:\ESH\esh_watch_crawler
herdr  # 進入後可切換與管理多個 Agent 視窗
```

---

見 todo.md #5(落地 C:\ESH 的 Claude × Antigravity v2.1 方案)與相關專案的 DEVELOPMENT_HANDOFF.md。
