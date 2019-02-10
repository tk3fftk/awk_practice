#!/bin/bash

# FS: Field Separator
## 1つのレコードを複数フィールドに分割するためのもの
## デフォルトではスペース or タブ文字(実際はスペース1つ)
# NF: Number of Field
## レコードでのフィールド数
# FSを変更する
echo "a,b,c" | awk -F',' '{print $2}'
## b
# FSには正規表現を用いることもできる
date | awk -F'[ :/]' '{print $4, $5, $6}'

# 指定フィールドを消すには空文字を代入する
echo "a b c" | awk '{$2 = ""; print}'
## a  c
# printf
echo "a b c" | awk '{printf("%s %s\n", $1, $3)}'
## a c
# 指定範囲でフィールドを抜き出す
## OFS: Output Field Separator
## 文字列同士を繋げる場合はスペースを挟んで連続で記述する
echo "a b c" | awk '{i = 2; while (i <= NF) a = a OFS $(i++); print a}'
## b c
# フィールドの再構築
## $1 = $1 という記述方法を指す
echo 'a,b,c' | awk -F',' -v OFS=' ' '$1 = $1'
## a b c
