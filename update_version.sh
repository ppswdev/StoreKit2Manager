#!/bin/bash

# StoreKit2Manager 版本自动升级脚本
# Usage: ./update_version.sh <新版本号>

set -e

# 检查参数
if [ $# -ne 1 ]; then
    echo "用法: $0 <新版本号>"
    echo "例如: $0 1.0.7"
    exit 1
fi

NEW_VERSION=$1
CURRENT_DATE=$(date +"%Y-%m-%d")

echo "开始升级到版本 $NEW_VERSION..."

# 2. 更新README.md中的版本引用
echo "更新README.md中的版本引用..."
# 使用sed替换SPM依赖版本
sed -i '' "s/from: \"[0-9]\+\.[0-9]\+\.[0-9]\"/from: \"$NEW_VERSION\"/g" README.md

# 3. 更新podspec版本
echo "更新StoreKit2Manager.podspec版本..."
sed -i '' "s/version.*=.*'[0-9]\+\.[0-9]\+\.[0-9]'/version          = '$NEW_VERSION'/g" StoreKit2Manager.podspec

# 4. 验证Swift构建
echo "验证Swift构建..."
swift build

# 5. 验证podspec
echo "验证podspec文件..."
pod lib lint StoreKit2Manager.podspec --allow-warnings

# 6. 提交更改
echo "提交更改..."
git add .
git commit -m "升级到$NEW_VERSION版本"

# 7. 创建版本标签
echo "创建版本标签 $NEW_VERSION..."
git tag $NEW_VERSION

# 8. 推送代码和标签
echo "推送代码和标签到GitHub..."
git push origin main
git push origin --tags

# 9. 自动发布到CocoaPods
echo "发布到CocoaPods..."
pod trunk push StoreKit2Manager.podspec --allow-warnings

echo "\n🎉 版本升级完成!"
echo "已成功将版本 $NEW_VERSION 发布到GitHub和CocoaPods!"
echo "\n请记得检查并更新CHANGELOG.md中的具体变更内容。"