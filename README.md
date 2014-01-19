files-md5-upload
================

part of "files" project

## 概要
ストレージ内の全ファイルのハッシュ値（MD5 checksum）を算出し、ファイルに出力するスクリプトです。

卒業研究で行っているプロジェクトのコードの一部となります。

## 詳細
1. files.rbにてストレージ内全ファイルのハッシュ値を計算
2. md5.txtにmd5を保存

なお、ファイルの生成に数十〜数百MBの容量が必要になります。


## 実行方法
```
ruby files.rb > /dev/null &
```

隠しファイル読み取りのためには、sudoで実行する必要があります（今回の実験では必要ありません）
