---
name: handoff
description: session 結束前更新 STATE.md 交接檔。當任務完成、被中斷、或 session 即將結束,需要把進度與教訓交接給下一個 session 時使用。
---

# handoff:更新 STATE.md

1. 讀現有的 `STATE.md`。
2. 依下列模板**整份重寫**(不是 append):已完成的項目移除、過時的現況改掉,
   只有「地雷與教訓」是累積制,新的往上加。

   ```markdown
   # STATE.md — session 交接檔

   最後更新:<日期> / 任務:<一句話>

   ## 現況
   <1–3 行:repo 現在處於什麼狀態>

   ## 進行中(含下一步)
   - [ ] <工作項>:做到 <哪裡>;下一步 <具體動作>;相關檔案 <路徑:行號>

   ## Backlog(發現但未做)
   - <項目>(來源:<哪次任務>)

   ## 地雷與教訓
   - <日期> <一句話:什麼坑、怎麼避開>
   ```

3. 驗收判準:下一個 session **只讀這份檔案**,能不能不重複你已做過的探索、
   直接從你停下的地方接手?不能 → 補到能。
4. 大小上限:全檔超過 150 行時,把最舊的教訓搬到 `docs/handoff-archive.md`(沒有就建)。
5. commit + push(見 `docs/playbooks/git.md`)。

## 好壞範例

- ❌ 「修了一些 bug,還有一些沒修完。」——下一個 session 要全部重查,等於沒交接。
- ✅ 「auth.py:42 的 token 過期判斷已修並有測試;retry 邏輯只完成一半:
  `retry()` 已寫好但尚未接上 caller(見 client.py:88),下一步是把 timeout 參數傳進去。」
