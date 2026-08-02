# C:\COWORK 專案盤點

最後更新:2026-08-02
資料來源:使用者提供的 Windows 檔案總管搜尋截圖(搜尋條件 `C:\COWORK\*.md`)

## 這份檔案的可信度界線(先讀這段)

本檔記錄的是**檔名與所在路徑**,這是截圖上直接可見的事實。

**本 session 沒有讀過任何一個檔案的內容。** `C:\COWORK` 在使用者的 Windows 本機,
雲端 session 無存取權。下方「觀察」一節是純粹從檔名/路徑結構推論出來的,標示為推論;
任何 AI session 若要根據這些檔案的**內容**做事,必須先請使用者貼上內容,
或把該專案推到本 session 讀得到的 repo,不得憑本檔臆測。

截圖底部疑似被視窗邊界裁切,故本清單**未必完整**——可能還有未列出的 .md 檔。

## 目錄結構

```
C:\COWORK\
├── todo.md
├── PROJECT_PROVENANCE_SCAN.md
├── COWORK_SCAN_FINAL.md
├── PIC2PDF\
│   ├── AGENTS.md
│   ├── CLAUDE.md
│   └── DEVELOPMENT_HANDOFF.md
├── PKM\
│   ├── README.md
│   ├── CONTEXT.md
│   ├── AGENTS.md
│   ├── PKM_規劃書.md
│   ├── 筆記格式規範.md
│   ├── docs\adr\
│   │   ├── 0001-local-markdown-is-source-of-truth.md
│   │   ├── 0002-two-layer-note-lifecycle.md
│   │   ├── 0003-frontmatter-controls-cloud-boundary.md
│   │   └── 0004-separate-version-history-from-disaster-recovery.md
│   ├── docs\debugging\
│   │   ├── README.md
│   │   └── 2026-08-02-initial-hardening-lessons.md
│   ├── _templates\
│   │   ├── 範本-隨手捕捉.md
│   │   ├── 範本-資源筆記.md
│   │   ├── 範本-領域筆記.md
│   │   ├── 範本-專案筆記.md
│   │   └── 範本-錄音筆記.md
│   └── 03-Resources\Glossary\
│       ├── 人名.md
│       ├── 公司與單位.md
│       ├── 專案名稱.md
│       ├── 技術名詞.md
│       └── 台語與常見誤辨詞.md
├── ConvertALL\
│   └── DEVELOPMENT_HANDOFF.md
├── CLIP\
│   ├── CLAUDE.md
│   └── DEVELOPMENT_HANDOFF.md
├── PPT\NotebookLM\
│   └── 開發交接紀錄_Codex.md
├── FTA_MCS_UI\
│   ├── README.md
│   └── DEVELOPMENT_HANDOFF.md
└── ComfyUI\workflows\
    └── README.md
```

## 專案一覽(名稱與用途推測)

| 專案 | 從檔名可知 | 用途(**推測,未證實**) |
|------|-----------|----------------------|
| `PKM` | 制度最完整:ADR 4 篇、debugging 紀錄、5 種筆記範本、5 份詞彙表 | 個人知識管理系統,本機 Markdown 為事實來源 |
| `PIC2PDF` | 有 AGENTS.md + CLAUDE.md + 交接檔 | 圖片轉 PDF 工具 |
| `CLIP` | 有 CLAUDE.md + 交接檔 | 未知 |
| `ConvertALL` | 僅交接檔 | 格式轉換工具 |
| `FTA_MCS_UI` | README + 交接檔 | 故障樹分析(FTA)最小割集(MCS)的 UI |
| `PPT\NotebookLM` | 交接檔由 Codex 撰寫 | 簡報相關,曾用 OpenAI Codex 協作 |
| `ComfyUI\workflows` | 僅 README | ComfyUI 工作流(圖像生成) |

## 觀察(推論,非證實)

1. **PKM 是目前制度最成熟、最活躍的專案。** 它有 `docs/adr/`(已到 0004)與
   `docs/debugging/`,結構與本 repo(James)的制度同構;且
   `2026-08-02-initial-hardening-lessons.md` 的日期就是今天,代表正在密集開發中。
   PKM 的 ADR 0001「local-markdown-is-source-of-truth」與 0003「frontmatter-controls-cloud-boundary」
   顯示它已經處理過「哪些筆記可以上雲」這個隱私邊界問題。

2. **AI 指示檔命名不統一。** `CLAUDE.md`(PIC2PDF、CLIP)、`AGENTS.md`(PIC2PDF、PKM)
   兩種並存,PIC2PDF 甚至兩個都有。不同 AI 工具(Claude Code / Codex / Antigravity)
   各讀各的檔名,長期會造成規則漂移——同一專案兩份指示互相矛盾時,沒人知道誰說了算。

3. **交接檔命名不統一。** 多數是 `DEVELOPMENT_HANDOFF.md`,但
   `PPT\NotebookLM` 用 `開發交接紀錄_Codex.md`(中文檔名 + 工具名後綴)。

4. **`C:\COWORK` 根目錄已有自己的 `todo.md`。** 與本 repo 的 `todo.md` 是**兩份不同的清單**,
   不要混淆。另有 `PROJECT_PROVENANCE_SCAN.md` 與 `COWORK_SCAN_FINAL.md`,
   檔名顯示使用者先前已做過一次跨專案盤點——**內容未讀,可能與本檔重疊或牴觸**,
   下次有機會應請使用者貼上比對。

5. **不在 `C:\COWORK` 底下的已知專案:** 職安衛 OCR pipeline、`C:\ESH`(esh_watch_crawler)。
   這兩個在先前對話出現過,但不在這次截圖的範圍內。

## 給下一個 session 的提醒

- 使用者提到上表任一專案時,先講清楚「我讀不到那個專案的程式碼」,再基於使用者貼上的內容作業。
- 若使用者要求「統一各專案的 AI 指示檔/交接檔規範」,觀察 2 與 3 是現成的切入點,
  但動手前要先取得各檔實際內容,不能照本檔的推測去改。
