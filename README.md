# 東京都環境計画書 集計ツール (energy_web)

Streamlit製の専用部・共用部PDF集計ツール。

## 機能
- 専用部PDF（住戸別の一次エネ計算書）から消費電力量を抽出
- 共用部PDF（非住宅版エネルギー消費性能計算書）から建物全体・太陽光削減量を抽出
- 住戸リストCSVと組み合わせて建物全体の消費電力量を集計
- Excel / PDF レポート出力

## 対応PDFフォーマット
- 共用部PDF: Ver.3.10 (2026.04) 以降の新形式（4ページ目に二次エネ、太陽光は正値）
- 旧形式（3ページ目に二次エネ、太陽光はマイナス符号）も後方互換

## ローカル実行
```bash
pip install -r requirements.txt
streamlit run app.py
```

## デプロイ
Render の Blueprint (`render.yaml`) で自動構成。
