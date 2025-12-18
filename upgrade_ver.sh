#!/bin/bash

# StoreKit2Manager 版本自动升级脚本
# Usage: 
# 授权：chmod +x upgrade_ver.sh
# 执行：./upgrade_ver.sh <新版本号>

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

# 1. 手动修改CHANGELOG.md
echo "确保手动修改CHANGELOG.md，添加版本 $NEW_VERSION 的变更内容。再执行当前脚本"

# 2. 更新README.md中的版本引用
 echo "更新README.md中的版本引用..."
 # 使用更精确的匹配模式来替换版本号
 # 匹配完整的SPM依赖行
 ruby -pi -e "gsub(/(\.package\(url: \"https:\/\/github\.com\/ppswdev\/StoreKit2Manager\.git\",\s*from: \s*\")[0-9]+\.[0-9]+\.[0-9]+(\")/, '\\1$NEW_VERSION\\2')" README.md
 # 检查是否替换成功
 grep -q "from: \"$NEW_VERSION\"" README.md && echo "✓ README.md版本号已更新为 $NEW_VERSION" || echo "✗ README.md版本号更新失败"

# 3. 更新podspec版本
echo "更新StoreKit2Manager.podspec版本..."
# 使用更精确的匹配模式，保持原有空格格式
ruby -pi -e "gsub(/spec.version\s*=\s*\"[0-9]+\.[0-9]+\.[0-9]+\"/, 'spec.version      = \"$NEW_VERSION\"')" StoreKit2Manager.podspec

# 4. 验证Swift构建
echo "验证Swift构建..."
swift build

# 5. 验证podspec
echo "验证podspec文件..."
pod lib lint StoreKit2Manager.podspec --allow-warnings

# 6. 提交更改
echo "提交更改..."
git add .
git commit -m "升级到${NEW_VERSION}版本"

# 7. 创建版本标签
echo "创建版本标签 ${NEW_VERSION}..."
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