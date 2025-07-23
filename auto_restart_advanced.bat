@echo off
REM Advanced Automatic Restart Script
REM Includes Error Handling and User Options
REM Author: Automatically Generated
REM Creation Date: July 21, 2025

setlocal enabledelayedexpansion
title Automatic Restart Script

REM Check Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges to perform restart operations.
    echo Please run this script as an administrator.
    pause
    exit /b 1
)

REM Log Start Time
set start_time=%date% %time%
echo Restart Execution Time：!start_time!
echo Restart Execution Time：!start_time! >> C:\Windows\Temp\auto_restart_log.txt

echo.
echo ========================================
echo        Automatic Restart Script
echo ========================================
echo.
echo The system will automatically restart in 3 minutes.
echo If you wish to cancel, press Ctrl+C during the countdown.
echo.

REM Countdown (180 seconds = 3 minutes)
for /L %%i in (180,-1,1) do (
    set /a minutes=%%i/60
    set /a seconds=%%i%%60
    echo Remaining time: !minutes! min !seconds! sec
    timeout /t 1 /nobreak >nul
)

echo.
echo Preparing to restart...

REM Log Restart Time
set restart_time=%date% %time%
echo Restart Execution Time：!restart_time!
echo Restart Execution Time：!restart_time! >> C:\Windows\Temp\auto_restart_log.txt


REM Execute Restart
shutdown /r /t 5 /c "Automatic Restart Script - The system will restart in 5 seconds."
echo The restart command has been executed, the system will restart in 5 seconds....
timeout /t 5 /nobreak >nul