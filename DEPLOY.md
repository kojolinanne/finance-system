# 開發與部署指南

## 🚀 快速開始

### 1. 修改程式碼後同步

最簡單的方式是使用同步腳本：

```bash
cd /home/openclaw/.openclaw/workspace/finance-system
./sync.sh "你的 commit 訊息"
```

這個腳本會自動：
- ✅ 提交變更到 Git
- ✅ 推送到 Apps Script
- ✅ 推送到 GitHub

### 2. 手動操作

如果你想要分開操作：

#### 推送到 Apps Script

```bash
cd /home/openclaw/.openclaw/workspace/finance-system
clasp push
```

#### 推送到 GitHub

```bash
cd /home/openclaw/.openclaw/workspace/finance-system
git add .
git commit -m "你的 commit 訊息"
git push origin main
```

## 📥 從 Apps Script 拉取最新版本

如果你在線上編輯器修改了程式碼，記得拉回本地：

```bash
cd /home/openclaw/.openclaw/workspace/finance-system
clasp pull
```

拉取後別忘了提交到 GitHub：

```bash
git add .
git commit -m "從 Apps Script 同步最新變更"
git push origin main
```

## 🌐 部署 Web App

### 建立新部署

```bash
clasp deploy --description "版本說明"
```

### 更新現有部署

```bash
# 列出所有部署
clasp deployments

# 更新特定部署
clasp deploy --deploymentId <deployment-id> --description "更新說明"
```

### 查看 Web App URL

```bash
clasp deployments
```

## 🔗 重要連結

### Apps Script
- **編輯器**: https://script.google.com/home/projects/1MDBUiE7x9wnH3oysUoPyYgAbUNERlRCU9jl5LVJrc2tinMi_yemmmhhE/edit
- **Script ID**: `1MDBUiE7x9wnH3oysUoPyYgAbUNERlRCU9jl5LVJrc2tinMi_yemmmhhE`

### Google Sheets
- **試算表**: https://docs.google.com/spreadsheets/d/1_caJxWmBVuuNCfeIBBmMhqnfUctdK1VOv80wodCu_sg/edit
- **Sheet ID**: `1_caJxWmBVuuNCfeIBBmMhqnfUctdK1VOv80wodCu_sg`

### GitHub
- **Repository**: https://github.com/kojolinanne/finance-system
- **Owner**: kojolinanne

## 🛠️ 常用命令

### clasp 命令

```bash
clasp status              # 查看本地與遠端差異
clasp open               # 在瀏覽器開啟 Apps Script 編輯器
clasp logs               # 查看執行日誌
clasp deployments        # 列出所有部署
```

### git 命令

```bash
git status               # 查看變更狀態
git log --oneline        # 查看提交歷史
git diff                 # 查看變更內容
git pull origin main     # 從 GitHub 拉取最新版本
```

## 📋 工作流程建議

### 開發新功能

1. 拉取最新版本：
   ```bash
   clasp pull
   git pull origin main
   ```

2. 編輯程式碼
   - 修改 `Code.js` 或 `Index.html`

3. 本地測試（在 Apps Script 編輯器）

4. 同步到遠端：
   ```bash
   ./sync.sh "新增：XXX功能"
   ```

### 緊急修復

如果在線上編輯器直接修改：

1. 拉回本地：
   ```bash
   clasp pull
   ```

2. 同步到 GitHub：
   ```bash
   git add .
   git commit -m "修復：XXX問題"
   git push origin main
   ```

## ⚠️ 注意事項

### .clasp.json 不要推送到 GitHub

`.gitignore` 已設定忽略 `.clasp.json`，因為它包含專案的 Script ID。

如果需要在其他電腦開發：

1. Clone GitHub repository
2. 執行 `clasp clone 1MDBUiE7x9wnH3oysUoPyYgAbUNERlRCU9jl5LVJrc2tinMi_yemmmhhE`

### 衝突處理

如果 Apps Script 和本地同時有修改：

```bash
# 先備份本地變更
cp Code.js Code.js.backup

# 拉取遠端版本
clasp pull

# 手動合併變更
# 然後推送
./sync.sh "合併衝突"
```

## 🎯 最佳實踐

1. **定期同步** - 每次修改後都執行 `./sync.sh`
2. **有意義的 commit 訊息** - 清楚說明變更內容
3. **小步提交** - 每個功能單獨提交，不要累積太多變更
4. **測試後再推送** - 確保功能正常才推送到正式環境

## 📞 需要幫助？

如果遇到問題，可以：
1. 查看 clasp 文檔：https://github.com/google/clasp
2. 查看 Apps Script 文檔：https://developers.google.com/apps-script
3. 聯絡維護者：lovejoanne1111@gmail.com
