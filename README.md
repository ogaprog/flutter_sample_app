# flutter_sample_app

## 概要

このアプリはFlutter製のサンプルアプリで、スマートフォンの基本的な機能を体験できます。

- **カメラ機能**  
  端末のカメラを利用してプレビュー表示します。
- **Bluetooth機能**  
  端末のBluetoothデバイス一覧を取得・表示します。
- **WebView機能**  
  アプリ内でWebページ（例: https://flutter.dev）を表示します。

## 主要技術・パッケージ

- [camera](https://pub.dev/packages/camera) : カメラ機能
- [flutter_blue](https://pub.dev/packages/flutter_blue) : Bluetooth機能
- [webview_flutter](https://pub.dev/packages/webview_flutter) : WebView機能

## 動作環境

- Flutter 3.7.2 以上
- Android/iOS/Windows/macOS/Linux/Web対応

## 使い方

1. リポジトリをクローン
2. 依存パッケージをインストール  
   ```
   flutter pub get
   ```
3. 実行  
   ```
   flutter run
   ```

## 画面構成

- 下部ナビゲーションバーで「カメラ」「Bluetooth」「WebView」を切り替え可能

---

本アプリはFlutterの基本機能の学習・検証用サンプルです。