@echo off
REM 自動安裝腳本 - 將自動重開機腳本設為開機啟動
REM 作者：自動生成
REM 建立日期：2025年7月21日

setlocal enabledelayedexpansion
title 自動重開機腳本安裝程式

echo ========================================
echo     自動重開機腳本安裝程式
echo ========================================
echo.

REM 檢查管理員權限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo 此安裝程式需要管理員權限。
    echo 請以管理員身份執行此腳本。
    pause
    exit /b 1
)

echo 請選擇要安裝的腳本版本：
echo.
echo 1. 基本版本 (auto_restart.bat)
echo 2. 進階版本 (auto_restart_advanced.bat) [推薦]
echo 3. 靜默版本 (auto_restart_silent.vbs)
echo 4. 取消安裝
echo.
set /p choice="請輸入選項 (1-4): "

if "%choice%"=="1" (
    set script_file=auto_restart.bat
    set script_name=自動重開機(基本版)
) else if "%choice%"=="2" (
    set script_file=auto_restart_advanced.bat
    set script_name=自動重開機(進階版)
) else if "%choice%"=="3" (
    set script_file=auto_restart_silent.vbs
    set script_name=自動重開機(靜默版)
) else if "%choice%"=="4" (
    echo 安裝已取消。
    pause
    exit /b 0
) else (
    echo 無效的選項，安裝已取消。
    pause
    exit /b 1
)

REM 檢查腳本檔案是否存在
if not exist "%~dp0!script_file!" (
    echo 錯誤：找不到腳本檔案 "!script_file!"
    echo 請確認腳本檔案在同一個資料夾中。
    pause
    exit /b 1
)

echo.
echo 選擇安裝方式：
echo.
echo 1. 啟動資料夾 (推薦，簡單易移除)
echo 2. 工作排程器 (更穩定，更多選項)
echo.
set /p install_method="請選擇安裝方式 (1-2): "

if "%install_method%"=="1" (
    REM 複製到啟動資料夾
    set startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
    copy "%~dp0!script_file!" "!startup_folder!\" >nul
    if %errorLevel%==0 (
        echo.
        echo ✓ 腳本已成功安裝到啟動資料夾
        echo   位置: !startup_folder!\!script_file!
    ) else (
        echo.
        echo ✗ 安裝失敗，無法複製檔案到啟動資料夾
    )
) else if "%install_method%"=="2" (
    REM 使用工作排程器
    set script_path=%~dp0!script_file!
    schtasks /create /tn "!script_name!" /tr "\"!script_path!\"" /sc onstart /ru "SYSTEM" /f >nul 2>&1
    if %errorLevel%==0 (
        echo.
        echo ✓ 腳本已成功安裝到工作排程器
        echo   工作名稱: !script_name!
    ) else (
        echo.
        echo ✗ 安裝失敗，無法建立排程工作
    )
) else (
    echo 無效的選項，安裝已取消。
    pause
    exit /b 1
)

echo.
echo ========================================
echo 安裝完成！
echo.
echo ⚠️ 重要提醒：
echo   - 此腳本會在開機3分鐘後自動重開機
echo   - 請確保所有重要資料已儲存
echo   - 重開機後此腳本會再次執行
echo.
echo 如需移除：
if "%install_method%"=="1" (
    echo   - 刪除檔案: !startup_folder!\!script_file!
) else (
    echo   - 執行命令: schtasks /delete /tn "!script_name!" /f
)
echo.
echo 按任意鍵結束安裝程式...
pause >nul
