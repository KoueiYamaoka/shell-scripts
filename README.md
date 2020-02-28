# 個人用シェルスクリプト
## pdfcrops
    ``` shell
	$ pdfcrops *.pdf
	```
	- pdfcrop コマンドを入力ファイル全てに対して行う
	- ついでに extractbb もする
	- オリジナルのファイルは old/ 以下に保存される

## latex2txt
    ``` shell
	$ latex2txt filename.tex (or filename)
	```
	- tex ファイルを txt ファイルに変換する
	- 面倒なので引数処理をしていない．ファイル内の parameters を直接いじること

## pdf_reduce*
    - pdf のサイズ削減のために用意したスクリプト
	- 削減されるとは限らない
