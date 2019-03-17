#!/bin/bash

echo '1 2 3 4 5' | awk '{print $1 + $2 - $3 * $4 / $5}'

# 乱数
## rand()
## 何回実行しても同じ値を返す
awk 'BEGIN { print rand() }'
## 0.840188
## srand(): seedを初期化する
awk 'BEGIN { srand(); print rand() }'
## 特殊な記法: unixtimeを出す
awk 'BEGIN { print srand() + srand() }'
## 1552827413

# 整数化
awk 'BEGIN { print int(1.5) }'
## 1
