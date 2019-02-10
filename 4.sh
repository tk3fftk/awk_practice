#!/bin/bash

# 文字列の抜き出し
## index(): 検索対象文字列, 検索したい文字列 => 検索したい文字列の先頭位置を返す
echo abcde | awk '$0 = substr($0, index($0, "b"))'
## bcde

# 文字列検索
## match(): 検索対象文字列, 検索する正規表現 => RSTART, RLENGTHをセット
echo abcde | awk 'match($0, /b.*/) {print RSTART, RLENGTH}'
## 2 4 
## $0の2文字目から4文字目が該当した部分ということ
# マッチ部分の抜き出し (grep -oでできる)
echo abcde | awk 'match($0, /b.*/) {print substr($0, RSTART, RLENGTH)}'
## bcde

# 文字列置換
## sub(): 置換対象になる正規表現, 置換後文字列, (置換対象文字列 | $0) => 最初にマッチした文字列だけを置換, 戻り値は置換に成功した個数
## gsub(): 置換対象になる正規表現, 置換後文字列, (置換対象文字列 | $0) => 全部〃, 戻り値は置換に成功した個数
echo abcde | awk '{sub(/./, "A"); print $0}'
## Abcde
echo abcde | awk '{gsub(/./, "A"); print $0}'
## AAAAA

## 文字列連結
echo abcde | awk '{print $0 "fghij"}'
## abcdefghij
echo abcde | awk '{print sprintf("%s%s", $0, "fghij")}'
## abcdefghij

## 大文字小文字変換
echo abcde | awk '$0 = toupper($0)'
# ABCDE
echo ABCDE | awk '$0 = tolower($0)'
# abcde
