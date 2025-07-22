@echo off
REM Advanced Auto Restart Script
REM Includes error handling and user options
REM Author: Auto-generated
REM Created: July 21, 2025

setlocal enabledelayedexpansion
title Auto Restart Script

REM Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges to perform restart operation.
    echo Please run this script as administrator.
    pause
    exit /b 1
)

REM Log start time
set start_time=%date% %time%
echo Script start time: !start_time!
echo Script start time: !start_time! >> C:\Windows\Temp\auto_restart_log.txt

echo.
echo ========================================
echo         Auto Restart Script
echo ========================================
echo.
echo System will automatically restart in 3 minutes
echo If you want to cancel, press Ctrl+C during the countdown
echo.

REM Countdown (180 seconds = 3 minutes)
for /L %%i in (180,-1,1) do (
    set /a minutes=%%i/60
    set /a seconds=%%i%%60
    echo Time remaining: !minutes! minutes !seconds! seconds
    timeout /t 1 /nobreak >nul
)

echo.
echo Preparing to restart...

REM Log restart time
set restart_time=%date% %time%
echo Restart execution time: !restart_time! >> C:\Windows\Temp\auto_restart_log.txt

REM Execute restart
shutdown /r /t 5 /c "Auto Restart Script - System will restart in 5 seconds"

echo Restart command executed, system will restart in 5 seconds...
timeout /t 5 /nobreak >nul
