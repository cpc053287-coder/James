# todo.md — 待辦事項(單一事實來源)

規則:待辦一律記在這裡;`STATE.md` 的 Backlog 只放一行指標指向本檔(見 `docs/decisions/0002-todo-single-source.md`)。
本清單按**應執行的先後順序**排列;完成後打勾並移到最下方「已完成」區留檔。

## 待辦(依優先順序)

### 1. 把 GitHub 預設分支改名為 `main`(使用者操作)

- [ ] GitHub → Settings → General → Default branch → 鉛筆圖示,把
      `claude/fable5-system-design-jem9sn` 改為 `main`(GitHub 會自動重導向舊名)。
- 為什麼排第一:改名影響之後所有 clone 與 session 的基準分支;在第 2 項 clone **之前**做最乾淨。
  若先 clone 才改名,本機要補:`git fetch origin && git checkout main`(或 `git remote set-head origin -a`)。

### 2. Windows 本機取得經驗紀錄並複製到 C:\COWORK\Experience(使用者操作)

- [ ] 在 Windows 開 PowerShell,執行:
      ```
      git clone https://github.com/cpc053287-coder/James.git
      cd James
      powershell -ExecutionPolicy Bypass -File scripts\sync-experience.ps1
      ```
- 私有 repo:clone 時會跳 GitHub 登入視窗,用本人帳號登入即可。
- 之後要更新本機經驗檔:在 repo 目錄重跑同一支腳本即可(會自動 pull + 覆蓋)。
- 注意:`scripts/sync-experience.ps1` 尚未在 Windows 實機跑過(撰寫環境無 PowerShell),
      第一次執行若報錯,把紅字訊息貼給 AI session 修正。

### 3. 填 CLAUDE.md 第 4 節「專案指令表」(AI session;第一個把程式碼帶進 repo 時觸發)

- [ ] 偵測專案類型 → 逐條實跑並填入安裝/建置/測試/lint/執行指令 → 補「專案備註」→ commit。

### 4. 順帶驗證制度未實測路徑(AI session;遇到即驗,不必專程)

- [ ] `docs/playbooks/debugging.md` 除錯流程(需一個真實 bug)
- [ ] 「同一問題失敗兩次即熔斷」(鐵律 6 + stuck.md)
- [ ] 破壞性動作攔截(鐵律 3)
- 任何一條在弱模型上失靈 → 走 `CLAUDE.md` 第 6 節修憲程序修正,附 ADR。

## 已完成(留檔備查)

- [x] 2026-07-04 立憲:CLAUDE.md + 5 份 playbooks + ADR 制度 + handoff/adr skills(commit `1e6fcfc`)
- [x] 2026-07-05 Sonnet 冒煙測試通過:無提示下自主完成「讀 STATE → 分級 → 最小 diff → commit → push → 附證據」(commit `390a2d9`)
- [x] 2026-07-06 修憲 v1.1:待辦單一來源改為 todo.md(commit `d5a70b8`)
- [x] 2026-07-11 修正 CLAUDE.md 兩處 ADR 死連結(commit `445d7c6`)
