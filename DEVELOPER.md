# Finance System Developer Documentation

## 1. Overview
This repository is a Google Apps Script web app for church finance reporting, backed by a bound Google Sheet.

It provides:
- Income statement (`收支餘絀表`) with budget and mission-deduction display modes.
- Balance sheet (`資產負債表`).
- Budget-vs-actual drill-down modal from ledger detail.
- Elder mode (`長執會模式`) to hide personnel expense line-item details and show only aggregates.

Primary source files:
- Code.js
- Index.html
- appsscript.json
- sync.sh
- README.md
- DEPLOY.md

---

## 2. Architecture

```
Browser (Index.html)
  -> google.script.run RPC
Apps Script (Code.js)
  -> SpreadsheetApp.getActiveSpreadsheet()
Google Sheets tabs (data + config)
  -> JSON responses
Browser render (cards/tables/modal)
```

Runtime model:
- Backend: Apps Script V8 runtime.
- Frontend: Single HTML page with inline CSS/JS.
- Data store: Spreadsheet worksheets (no external DB).

---

## 3. Setup

### Prerequisites
- Node.js + npm (for `clasp`)
- Google account with access to script/sheet
- git
- @google/clasp

### Local setup
```bash
npm install -g @google/clasp
clasp login
clasp clone <SCRIPT_ID>
```

### Daily dev loop
```bash
clasp pull
# edit Code.js / Index.html
clasp push
```

---

## 4. Dependencies

### Runtime dependencies
- HtmlService
- SpreadsheetApp
- Utilities

### Tooling dependencies
- @google/clasp
- git
- bash (sync.sh)

No package.json/framework dependencies in this repo.

---

## 5. Scripts and Commands

### sync.sh
Behavior:
- Detects local git changes.
- Prompts/uses commit message.
- Runs `git add . && git commit`.
- Forces Apps Script push: `clasp push -f`.
- Pushes git branch: `git push origin main`.

Notes:
- `git add .` is broad and can include unintended files.
- `clasp push -f` overwrites remote script state.

---

## 6. Backend API and Key Modules (Code.js)

### Web entrypoint
- `doGet()` serves Index.html as web app output.

### Config/settings
- `getSettings()` reads 設定!A2 and parses elder mode truthy values.

### Filter bootstrap
- `getFilterOptions()` collects organizations + periods from statement sheets.

### Income statement API
- `getIncomeStatement(org, period)`:
  - Filters rows.
  - Splits income/expense.
  - Supports mission deduction amounts from columns H/I.
  - Applies elder mode personnel aggregation.

### Budget + actual detail API
- `getBudgetData(org)`:
  - Reads 預算資料, 預算明細, 詳細分類帳.
  - Builds items, detailMap, actualDetailMap.

### Balance sheet API
- `getBalanceSheet(org, period)`:
  - Splits assets/liabilities/equity.
  - Uses subtotal rows when present; otherwise computes fallbacks.

---

## 7. Frontend Modules (Index.html)

### Initialization
- `init()` calls getFilterOptions(), populates selects, loads default tab.

### Data loading
- `loadCurrentTab()`:
  - Income tab: parallel calls to getIncomeStatement() + getBudgetData().
  - Balance tab: getBalanceSheet(org, null).

### Rendering
- `renderIncome(data, budget)` creates summary cards + detailed budget table.
- `renderBalance(data)` creates two-sided balance-sheet table.
- `showDetailModal(...)` renders budget/actual drill-down modal.

---

## 8. Data Model and Flow

### Expected Sheets
- 收支餘絀表
- 資產負債表
- 預算資料
- 預算明細
- 詳細分類帳
- 設定

### High-level flow
1. UI boot -> getFilterOptions().
2. User selects org/period.
3. Income tab:
   - Fetch statement and budget data.
   - Client computes display mode (all vs deduct).
   - Client maps budget to accounts and calculates remaining/use-rate.
4. Detail modal:
   - Uses detailMap + actualDetailMap keyed by account/tag.
5. Balance tab:
   - Fetch grouped account data and render left/right sections.

---

## 9. Environment and Configuration

### Apps Script config (appsscript.json)
- runtimeVersion: V8
- timeZone: Asia/Taipei
- Web app access: ANYONE_ANONYMOUS
- Execute as: USER_DEPLOYING

### Operational config
- Elder mode toggle from 設定!A2.
- Mission deduction display mode from UI dropdown (all/deduct) and does not persist server-side.

### Local-only config
- .clasp.json is ignored by git and required per machine for clasp binding.

---

## 10. Deployment

### Manual deploy flow
```bash
clasp push
clasp deploy --description "release note"
clasp deployments
```

### Update existing deployment
```bash
clasp deploy --deploymentId <id> --description "update"
```

### Recommended sync flow
```bash
./sync.sh "commit message"
```

References:
- DEPLOY.md
- README.md

---

## 11. Troubleshooting

### getSheetByName(...) null / runtime errors
Cause:
- Missing/renamed worksheet tabs.
Fix:
- Verify exact tab names listed above.

### Empty screen after load
Cause:
- No organization selected or no data for selected period.
Fix:
- Confirm getFilterOptions() returns orgs/periods and source sheet has rows.

### Permission or 403 issues on web app
Cause:
- Deployment access/execution settings mismatch.
Fix:
- Re-deploy and verify ANYONE_ANONYMOUS + proper execute-as mode.

### Apps Script and local code diverged
Cause:
- Edited both cloud editor and local.
Fix:
```bash
clasp pull
# manually merge
clasp push
```

### Unexpected overwrite of cloud code
Cause:
- clasp push -f in sync.sh.
Fix:
- Use clasp status before pushing; consider removing -f for safer workflow.

### Budget detail modal shows no data
Cause:
- Key mismatch between detailTag/sub-account and ledger-derived keys.
Fix:
- Align 預算資料.detailTag, 預算明細.parentKey, and 詳細分類帳 account naming.

---

## 12. Gaps / Technical Debt
- No automated tests (unit/integration/e2e).
- No schema validation for sheet columns.
- Error handling is mostly alert(...) in client.
- App is deployed with anonymous access; review security posture.
