#!/bin/bash

# 进入interview文件夹
cd /Users/zhencaiwei/Desktop/github/web-demo-archive/interview

# 解压所有.zip文件
for file in *.zip; do
    echo "正在解压: $file"
    unzip "$file" -d "${file%.zip}"
    
    # 检查解压是否成功
    if [ $? -eq 0 ]; then
        echo "解压成功，删除原文件: $file"
        rm "$file"
    else
        echo "解压失败: $file"
    fi
done

echo "所有操作完成！"