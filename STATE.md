# STATE.md — session 交接檔

最後更新:2026-07-06 / 任務:立憲 session 收工交接(憲法升 v1.1,建立 todo.md)

## 現況

repo 已有完整工作制度、尚無程式碼。制度檔案:`CLAUDE.md`(憲法 v1.1)、`docs/playbooks/`(五份)、`docs/decisions/`(ADR 0001–0002)、`.claude/skills/`(handoff、adr)、`todo.md`(待辦單一來源)。制度已通過一次 Sonnet 冒煙測試(commit `390a2d9`):無提示下自主走完「讀 STATE → 分級 → 最小 diff → commit → push → 附證據」。GitHub 預設分支目前是 `claude/fable5-system-design-jem9sn`(已用 `git ls-remote --symref origin HEAD` 實測確認)。

## 進行中(含下一步)

- 無進行中的工作。下一個 session 從使用者的新任務開始;開工儀式照 CLAUDE.md 第 0 節。

## Backlog

- 見 `todo.md`(待辦單一來源,見 docs/decisions/0002;新發現的待辦寫進去,不寫在本檔)

## 地雷與教訓

- 2026-07-06 子代理的回報也適用鐵律 2:代理宣稱完成後,主 session 仍須親自用 `git log` / `git diff --stat` / `git ls-remote` 核實,不能只信自述。
- 2026-07-06 任何「平台應該會自動…」的假設(例:GitHub 把首推分支設為預設)都有一行指令可實測(`git ls-remote --symref origin HEAD`),先測再宣稱。
- 2026-07-04 本環境是暫時容器,session 結束就回收——**任何沒 push 的工作等於消失**,收工必 push。
- 2026-07-04 這個 repo 由不同等級的模型輪流接手。交接品質決定一切:更新本檔時,以「下一個 session 不重複我的探索就能直接接手」為驗收標準。
