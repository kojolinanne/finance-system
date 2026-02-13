#!/bin/bash
# 財務報表系統 - 同步腳本
# 用途：將本地修改同時推送到 Apps Script 和 GitHub

set -e

echo "🔄 開始同步財務報表系統..."
echo ""

# 取得當前目錄
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 檢查是否有未提交的變更
if [[ -n $(git status -s) ]]; then
    echo "📝 發現變更，準備提交..."
    git status -s
    echo ""
    
    # 詢問 commit message（如果沒有提供）
    if [ -z "$1" ]; then
        echo "請輸入 commit message:"
        read -r COMMIT_MSG
    else
        COMMIT_MSG="$1"
    fi
    
    # Git commit
    git add .
    git commit -m "$COMMIT_MSG"
    echo "✅ Git commit 完成"
    echo ""
else
    echo "ℹ️  沒有新的變更需要提交"
    echo ""
fi

# 推送到 Apps Script
echo "📤 推送到 Apps Script..."
clasp push -f
echo "✅ Apps Script 推送完成"
echo ""

# 推送到 GitHub
echo "📤 推送到 GitHub..."
git push origin main
echo "✅ GitHub 推送完成"
echo ""

echo "🎉 同步完成！"
echo ""
echo "📊 Apps Script: https://script.google.com/home/projects/1MDBUiE7x9wnH3oysUoPyYgAbUNERlRCU9jl5LVJrc2tinMi_yemmmhhE/edit"
echo "🐙 GitHub: https://github.com/kojolinanne/finance-system"
