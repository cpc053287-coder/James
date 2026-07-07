# 0002:待辦事項以根目錄 todo.md 為單一事實來源

日期:2026-07-06
狀態:生效

## 情境

使用者要求把需要延續的項目記錄到 `todo.md`。原制度把待辦放在 `STATE.md` 的
Backlog 區;若兩處並存,弱模型 session 很容易只更新其一,造成兩份互相矛盾的清單。

## 決定

待辦事項一律記在根目錄 `todo.md`;`STATE.md` 的 Backlog 區只保留一行:
「見 todo.md」。session 儀式中原本「記入 STATE.md Backlog」的動作,改為記入 todo.md。

## 理由與代價

使用者明確指定 todo.md(效力高於憲法);單一來源消除同步失敗的可能。
代價:CLAUDE.md 與 playbooks 中舊有的「記入 STATE.md Backlog」字句需一併更新,
否則規則自相矛盾——本 ADR 的 commit 已同步修改這些字句。
