#!/bin/bash
# パターン {アクション}

# awkの真偽
## 数字の0か空文字以外は真

# 正規表現基礎
echo "foo" | awk '$0 ~ /foo/'
echo "foo" | awk '/foo/'
echo "faa" | awk '!/foo/'

# 代入
echo "a b c" | awk '{$2 = "B"; print $0}'
## パターンでもできる
echo "a b c" | awk '$2 = "B"'
## 代入の戻り値は左辺値なのでこの場合は偽となり表示されない
echo "a b c" | awk '$2 = ""'
echo "a b c" | awk '{ print $2 = "B"}'
echo "a b c" | awk '{ print $2 = ""}'
echo "a b c" | awk '!($2 = "")'
## $1だけをprint使わずに表示する手法
echo "a b c" | awk '$0 = $1'

# 変数
## 組み込み変数
### レコード中のフィールド数を示す NF (Number of Field)
### レコード数を示す NR (Number of Record)
echo "a b c" | awk '{print NF}'
#### 3
echo "a b c" | awk '{print NR}'
#### 1
echo "a b c" | awk 'NF = 2'
#### a b
#### 改行だけの行が消せる
echo -e "\n a \n b \n \n" | awk 'NF'
#### a
#### b 

# 関数
## 戻り値は1つ
## length() 文字数を返す関数。引数がないと$0を使う。この場合は()も不要
echo "\n a \n b \n \n" | awk '{print length}'
### 15
## sub() 置換に成功すれば1を、失敗すれば0を返す
## gsub() 置換に成功した個数を数字で返す
echo "a b c" | awk '{print gsub(/a/, "")}'
### 1
## split($0, arr) $0を配列にしてarrに代入する
echo "ab ba ab" | awk 'split($0, arr) {print arr[1]}'
### ab
echo "ab ba ab" | awk 'split($0, arr) {print arr[2]}'
### ba
echo "ab ba ab" | awk 'split($0, arr) {print arr[3]}'
### ab
