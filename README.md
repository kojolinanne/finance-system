# 主恩改革宗長老會 - 財務報表系統

教會財務管理系統，使用 Google Apps Script 與 Google Sheets 建置。

## 功能特色

- 📊 **收支餘絀表** - 完整的收入支出報表
- 💰 **預算管理** - 預算編列與執行追蹤
- 📈 **資產負債表** - 教會資產狀況一覽
- 🔐 **長執會模式** - 敏感資料保護機制
- 📱 **響應式設計** - 支援手機、平板、電腦

## 專案結構

```
finance-system/
├── Code.js          # 後端邏輯（Google Apps Script）
├── Index.html       # 前端介面
├── appsscript.json  # 專案配置
└── README.md        # 說明文件
```

## 部署方式

### 前置需求

1. 安裝 [clasp](https://github.com/google/clasp)：
   ```bash
   npm install -g @google/clasp
   ```

2. 登入 Google 帳號：
   ```bash
   clasp login
   ```

### 部署到 Apps Script

```bash
# 推送程式碼
clasp push

# 部署為 Web App
clasp deploy
```

### 同步到 GitHub

```bash
# 提交變更
git add .
git commit -m "更新說明"
git push origin main
```

## Google Sheet 連結

- **Sheet ID**: `1_caJxWmBVuuNCfeIBBmMhqnfUctdK1VOv80wodCu_sg`
- **Apps Script ID**: `1MDBUiE7x9wnH3oysUoPyYgAbUNERlRCU9jl5LVJrc2tinMi_yemmmhhE`

## 工作表說明

| 工作表名稱 | 說明 |
|----------|------|
| 收支餘絀表 | 記錄各期收入與支出 |
| 預算 | 年度預算編列 |
| 設定 | 系統設定（長執會模式開關） |
| 資產負債表 | 教會資產與負債狀況 |
| 明細 | 詳細交易記錄 |
| 預算資料 | 預算資料來源（隱藏） |
| 預算明細 | 預算細項（隱藏） |
| 收支明細 | 實際支出明細（隱藏） |

## 開發指南

### 本地開發

1. Clone 專案到本地
2. 使用 `clasp clone <scriptId>` 下載最新程式碼
3. 編輯 `Code.js` 或 `Index.html`
4. 使用 `clasp push` 推送變更

### 測試

在 Apps Script 編輯器中可以測試個別函式：
- `getFilterOptions()` - 測試篩選選項
- `getIncomeStatement()` - 測試收支報表
- `getBalanceSheet()` - 測試資產負債表

## 授權

此專案僅供主恩改革宗長老會內部使用。

## 維護者

- linanne (lovejoanne1111@gmail.com)
