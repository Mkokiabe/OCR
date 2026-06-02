# OCR Tool (Drag and Drop)

このプロジェクトは、`yomitoku` を使って PDF / 画像 / 画像フォルダを OCR するためのツールです。
`drag_and_drop_ocr.bat` にファイルまたはフォルダを D&D すると、OCR を実行します。

## 仕様

- 入力対応:
	- PDF ファイル (`.pdf`)
	- 画像ファイル (`.png`, `.jpg`, `.jpeg`, `.bmp`, `.tif`, `.tiff`, `.webp`, `.gif`)
	- 画像が入ったフォルダ
- 出力先:
	- 画像抽出: `figure/`
	- 詳細解析結果: `analysis_results/`
- 実行時:
	- `.venv\Scripts\activate.bat` を呼び出して仮想環境を有効化
	- `yomitoku` を実行

## セットアップ

1. 仮想環境を作成

```powershell
uv venv
```

2. 仮想環境を有効化

```powershell
.\.venv\Scripts\Activate.ps1
```

3. 必要パッケージをインストール

```powershell
uv pip install yomitoku
```

## 使い方

1. `drag_and_drop_ocr.bat` をエクスプローラーで開く
2. OCR したい PDF / 画像 / フォルダを `drag_and_drop_ocr.bat` にドラッグ&ドロップ
3. OCR 完了後、以下を確認
	 - `analysis_results/` に解析結果（`md` 形式）
	 - `figure/` に図領域の画像

## 補足

- `drag_and_drop_ocr.bat` は複数ファイルの同時 D&D に対応しています。
- 対応拡張子以外はスキップされます。
- `yomitoku` が見つからない場合はエラー終了します。

## 参考

[^1]: `yomitoku -h` ヘルプ出力（本リポジトリ作業時のユーザー提供情報）

