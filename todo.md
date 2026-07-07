# todo.md — 待辦事項(單一事實來源)

規則:待辦一律記在這裡;`STATE.md` 的 Backlog 只放一行指標指向本檔(見 `docs/decisions/0002`)。
完成的項目打勾後保留一個 release 週期再刪;每項標明「誰能做」與「觸發時機」。

## 等使用者決定

- [ ] 把 GitHub 預設分支從 `claude/fable5-system-design-jem9sn` 改名為 `main`。
      做法:GitHub → Settings → General → Default branch → 鉛筆圖示改名(GitHub 會自動重導向)。
      (來源:2026-07-05 立憲 session;屬破壞性動作邊緣,由使用者親自操作或明確授權後執行)

## 等條件觸發(AI session 執行)

- [ ] **第一個把程式碼帶進 repo 的 session**:完成 `CLAUDE.md` 第 4 節「專案指令表」——
      偵測專案類型、逐條實跑並填入安裝/建置/測試/lint/執行指令,補「專案備註」,commit。
- [ ] **未來任務中順帶驗證制度未實測路徑**(遇到即驗,不必專程):
      - `docs/playbooks/debugging.md` 的除錯流程(需一個真實 bug)
      - 「同一問題失敗兩次即熔斷」(鐵律 6 + stuck.md)
      - 破壞性動作攔截(鐵律 3)
      任何一條在弱模型上失靈 → 走 `CLAUDE.md` 第 6 節修憲程序修正,附 ADR。

## 已完成(留檔備查)

- [x] 2026-07-04 立憲:CLAUDE.md + 5 份 playbooks + ADR 制度 + handoff/adr skills(commit `1e6fcfc`)
- [x] 2026-07-05 Sonnet 冒煙測試通過:無提示下自主完成「讀 STATE → 分級 → 最小 diff → commit → push → 附證據」(commit `390a2d9`)
