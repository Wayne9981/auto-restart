@echo off
REM 進階自動重開機腳本
REM 包含錯誤處理和用戶選項
REM 作者：自動生成
REM 建立日期：2025年7月21日

setlocal enabledelayedexpansion
title 自動重開機腳本

REM 檢查管理員權限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo 此腳本需要管理員權限才能執行重開機操作。
    echo 請以管理員身份執行此腳本。
    pause
    exit /b 1
)

REM 記錄開始時間
set start_time=%date% %time%
echo 腳本啟動時間：!start_time!
echo 腳本啟動時間：!start_time! >> C:\Windows\Temp\auto_restart_log.txt

echo.
echo ========================================
echo           自動重開機腳本
echo ========================================
echo.
echo 系統將在 3 分鐘後自動重開機
echo 如果您想取消，請在倒數計時期間按 Ctrl+C
echo.

REM 倒數計時（180秒 = 3分鐘）
for /L %%i in (180,-1,1) do (
    set /a minutes=%%i/60
    set /a seconds=%%i%%60
    echo 剩餘時間：!minutes! 分 !seconds! 秒
    timeout /t 1 /nobreak >nul
)

echo.
echo 準備重開機...

REM 記錄重開機時間
set restart_time=%date% %time%
echo 重開機執行時間：!restart_time! >> C:\Windows\Temp\auto_restart_log.txt

REM 執行重開機
shutdown /r /t 5 /c "自動重開機腳本 - 系統將在5秒後重開機"

echo 重開機命令已執行，系統將在5秒後重開機...
timeout /t 5 /nobreak >nul
