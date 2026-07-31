@echo off
rem 日本語表示のためコンソールのコードページをShift-JISに固定
chcp 932 >nul
setlocal
cd /d "%~dp0"
title energy-web (東京都環境計画書 消費電力量集計ツール)

set "PORT=8501"
set "VENV=%~dp0.venv"
set "PY=%VENV%\Scripts\python.exe"

echo ============================================================
echo  東京都環境計画書 消費電力量集計ツール  (ローカル実行)
echo ============================================================
echo.

rem ---- 初回のみ: Python仮想環境を自動作成 ----
if not exist "%PY%" (
    echo [初回セットアップ] Python仮想環境を作成しています...
    py -3 -m venv "%VENV%"
    if errorlevel 1 (
        echo.
        echo [エラー] Python が見つかりません。python.org から Python をインストールしてください。
        pause
        exit /b 1
    )
    echo [初回セットアップ] ライブラリをインストールしています。数分かかります...
    "%PY%" -m pip install --upgrade pip
    "%PY%" -m pip install -r "%~dp0requirements.txt"
    if errorlevel 1 (
        echo.
        echo [エラー] ライブラリのインストールに失敗しました。
        pause
        exit /b 1
    )
    echo [初回セットアップ] 完了しました。
    echo.
)

rem ---- 既に起動中なら二重起動せずブラウザだけ開く ----
netstat -an | findstr /c:"127.0.0.1:%PORT%" | findstr /c:"LISTENING" >nul
if not errorlevel 1 (
    echo 既に起動しています。ブラウザを開きます: http://localhost:%PORT%
    start "" "http://localhost:%PORT%"
    exit /b 0
)

echo ブラウザが自動で開きます: http://localhost:%PORT%
echo.
echo   終了するときは、この黒い画面で Ctrl + C を押すか
echo   ウィンドウを閉じてください。
echo ------------------------------------------------------------
echo.

"%PY%" -m streamlit run "%~dp0app.py" --server.port=%PORT% --server.address=localhost --server.headless=false --browser.gatherUsageStats=false --server.maxUploadSize=500

echo.
echo 終了しました。
pause
