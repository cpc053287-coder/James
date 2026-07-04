---
name: adr
description: 記錄一個會約束未來的技術決策(新依賴、資料 schema、對外介面、架構選型、跨檔案慣例)。在做出這類選擇之後、session 結束之前使用。
---

# adr:寫決策紀錄

1. 先套判準:**未來 session 想推翻這個選擇,成本高嗎?**
   高(換框架、改 schema、改 API 形狀)→ 寫。低(改個變數名)→ 不寫,結束。
2. 取號:`ls docs/decisions/` 看最大編號,+1,四位數。
3. 複製 `docs/decisions/0000-template.md` 為 `docs/decisions/NNNN-<英文短槽名>.md`,
   填滿三個欄位(情境 / 決定 / 理由與代價),每欄不超過 4 行。
   - 「決定」寫成祈使句,讓人能照做:「時間欄位一律存 UTC epoch 毫秒」。
   - 寫不出「代價」= 還沒想清楚,回去想清楚再寫。
4. 若這個決策推翻了舊 ADR:把舊檔「狀態」改為「已被 NNNN 取代」,**不刪舊檔**。
5. 與相關代碼一起 commit(或緊接著單獨 commit),push。
