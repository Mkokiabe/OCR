# 作業実績書: OCR出力構成の修正

## 概要
OCRバッチの出力先構成を修正し、OCR結果Markdownを `ocr_results` に保存、画像を `ocr_results/firgures` に保存、レイアウト解析・文字検出の可視化結果を `analysis_results` に保存するように変更した。あわせて README と `.gitignore` を新仕様に更新した。

## ゴール
- OCRしたmdの結果を `ocr_results` に格納する
- `ocr_results` 配下の `firgures` に画像を格納する
- `analysis_results` をレイアウトパーサ・テキスト検出の解析画像保存先にする
- OCR md の画像参照を相対パスにする

## 手順
1. 既存 `drag_and_drop_ocr.bat` の出力先定義を変更した。
2. OCR本体を `ocr_results` で実行し、`--figure_dir .\firgures` を指定した。
3. 可視化解析を別実行として `analysis_results` で `-v` 実行する構成にした。
4. README の仕様説明を新構成に更新した。
5. `.gitignore` を `ocr_results/` と `analysis_results/` を除外する設定に更新した。
6. バッチ起動確認とエラー確認を実施した。

## 実施結果の報告
- 更新:
  - `drag_and_drop_ocr.bat`
  - `README.md`
  - `.gitignore`
- 確認結果:
  - バッチの構文エラーなし
  - ワークスペースのエラーなし
- 補足:
  - OCR md の画像相対パス化は、`ocr_results` 直下で OCR 実行して `--figure_dir .\firgures` を指定する方式で実現した。
