# ことりと毎日

Qt Quick / QML で作った、オフライン動作のデスクトップペットアプリです。ペットのことりが今日の日付に合わせた記念日や、日々のひとことを共通の吹き出しで紹介します。

## 構成

- `main.cpp` — QMLホーム画面を起動するQtエントリーポイント
- `MainWindow.qml` — 日付、コンテンツ、ペット、操作ボタンを配置するホーム画面
- `components/` — 共通のコンテンツ表示、吹き出し、ペット表示と状態アニメーション
- `services/DateService.js` — 日付キー、表示用日付、うるう年の処理
- `content/ContentProvider.js` — 各コンテンツで共通利用するデータ形式
- `content/AnniversaryProvider.js` — 日付から記念日コンテンツを生成
- `content/data/anniversaries.js` — 366日分の記念日・出来事データ。説明はペットの会話口調
- `bird.svg` — 差し替え可能なペット画像
- `tests/test_content.js` — 日付、うるう日、コンテンツ生成のテスト
- `tests/tst_content.qml` — Qt Quick Testによる日付・コンテンツテスト

記念日プロバイダーは `{ id, category, title, dialogue, animation }` 形式のコンテンツを返します。UIは記念日の検索方法を知らず、同じ形式のコンテンツを追加すれば共通の表示部品を利用できます。日付はアプリ起動時に取得し、1分ごとに日付が変わったかを確認します。ネットワーク通信やOS固有APIは使用しません。

## ビルドと起動

Qt 6.10以降とCMakeを用意して、プロジェクトディレクトリで実行します。

```sh
cmake -S . -B build
cmake --build build
```

生成された `appdesktopPet` を起動します。Qt Creatorを使う場合は、ルートの `CMakeLists.txt` を開いて実行してください。

## テスト

Node.jsが利用できる環境では、プロジェクトディレクトリから実行します。

```sh
node tests/test_content.js
```

Qt Quick Testが利用できる環境では、次のように実行できます。

```sh
qmltestrunner -input tests
```

テストでは任意の日付を指定し、11月20日や1月2日の記念日、2月29日、うるう年判定、全366日分のデータ、会話口調、およびデータ未登録時のフォールバックを確認します。
