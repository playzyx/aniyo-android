#!/bin/bash

# 检查输入参数
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <manifest_file> <local_manifest_file>"
    exit 1
fi

MANIFEST_FILE=$1
LOCAL_MANIFEST_FILE=$2
NAME_CONTAINS=(
"device/amlogic" 
"device/common" 
"device/generic"  
"device/google" 
"device/linaro" 
"device/sample" 
"device/ti" 
"/darwin" 
"apps/Car/" 
"services/Car" 
"kernel/tests" 
"platform/test" 
"tools/test" 
"/hardware/qcom/" 
"/hardware/samsung" 
"/hardware/ti" 
"/hardware/google")


# 创建或清空local manifest文件
echo '<?xml version="1.0" encoding="UTF-8"?>' > $LOCAL_MANIFEST_FILE
echo '<manifest>' >> $LOCAL_MANIFEST_FILE
echo '    <remote name="github" fetch="ssh://git@ssh.github.com:443/playzyx/" revision="android-14" />' >>$LOCAL_MANIFEST_FILE
echo '    <!-- 添加自己的模块 -->' >>$LOCAL_MANIFEST_FILE
echo '    <project path="device/aniyo" name="android_device" remote="github" />' >>$LOCAL_MANIFEST_FILE
echo '    <project path="vendor/aniyo" name="android_vendor" remote="github" />' >>$LOCAL_MANIFEST_FILE
echo '    <project path="hardware/aniyo" name="android_hardware" remote="github" />' >>$LOCAL_MANIFEST_FILE
echo '    <!-- 移除这些仅仅是为了同步代码的的时候少拉一些不需要的代码,如果发现编译有依赖,请加回相关模块 -->' >>$LOCAL_MANIFEST_FILE

for str in "${NAME_CONTAINS[@]}"; do
    # 读取原始manifest文件，查找包含特定字段的项目名称，并生成remove-project标签
    grep "name=".*$str.*"" $MANIFEST_FILE | while read -r line ; do
        PROJECT_NAME=$(echo $line | sed -n 's/.*\(name="[^ ]*\).*/\1/p')
        echo $PROJECT_NAME 
        echo "    <remove-project $PROJECT_NAME />" >> $LOCAL_MANIFEST_FILE
    done
done

# 关闭manifest标签
echo '</manifest>' >> $LOCAL_MANIFEST_FILE

echo "Local manifest file $LOCAL_MANIFEST_FILE has been generated."
