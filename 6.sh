#!/bin/bash
# awk で使われる配列はすべて連想配列として扱われる
# awkの配列と連想配列
## 配列: インデックスが数字のもの
## 連想配列: インデックスが文字列であるもの

## 配列の例
### インデックスは数字ではあるが、awkに型はないので"1"がキーの連想配列と思えばよい
### length(): 引数がない場合は$0, 引数が変数の場合は変数の長さを、配列である場合は配列の長さを返す

awk 'BEGIN {
  fruits[1] = "Apple";
  fruits[2] = "Orange";
  fruits[3] = "Banana";

  for (i = 1; i <= length(fruits); i++) {
    print i, fruits[i];
  }

  # awkでは配列も連想配列なのでこの記法が使える
  for (i in fruits) {
    print i, fruits[i];
  }
}'

## 連想配列の例
### for in で連想配列のループ処理を行う
### 連想配列は何かの順番でソートされたりしているわけではない

awk 'BEGIN {
  price_of["Apple"] = 100;
  price_of["Orange"] = 200;
  price_of["Banana"] = 300;

  for (i in price_of) {
    print i, price_of[i];
  }

  # 存在確認 (空かどうかにも使える)
  if ("Kiwi" in price_of) {
    print "Kiwi is found"
  }
}'

## 疑似リスト
### split(): 第一引数を第三引数(default: FS)で分割し、第二引数に格納する。返り値は配列の長さになる

awk 'BEGIN {
  fruit_list = "Apple Orange Banana";
  num_fruits = split(fruit_list, fruits);

  for (i = 1; i <= num_fruits; i++) {
        print i, fruits[i];
  }
}'

## 多次元配列
### は、ないが擬似的にこれを補う機能がある

awk 'BEGIN {
  fruits[1, 1] = "Fuji Apple";
  fruits[1, 2] = "Tsugaru Apple";
  fruits[2, 1] = "Blood Orange";
  fruits[2, 2] = "Mikan";

  for (i = 1; i <= 2; i++) {
    for (j = 1; j <= 2; j++) {
      print i, j, fruits[i, j];
    }
  }

  # 内部的にはこう
  # 配列のインデックスをカンマで区切ると\034に展開される
  fruits[1"\034"1] = "Fuji Apple";
  fruits[1"\034"2] = "Tsugaru Apple";
  fruits[2"\034"1] = "Blood Orange";
  fruits[2"\034"2] = "Mikan";

  for (i = 1; i <= 2; i++) {
    for (j = 1; j <= 2; j++) {
      print i, j, fruits[i "\034" j];
    }
  }
}'

## 重複を削除するawk芸
### aは連想配列となる
### a["aaa"], a["bbb"]が加算されない最初だけ表示される
echo -e "aaa\nbbb\naaa" | awk '!a[$0]++'

### こうするとわかりやすい？
echo -e "aaa\nbbb\naaa" | awk '!a[$0]++ END {for (aa in a){print aa, a[aa];}}'
### aaa
### bbb
### bbb 1
### aaa 2

### 逆はこう
echo -e "aaa\nbbb\naaa" | awk 'a[$0]++ == 1'
### aaa
