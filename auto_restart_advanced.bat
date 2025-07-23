@echo off
REM Advanced Automatic Restart Script
REM Includes Error Handling and User Options
REM Author: Automatically Generated
REM Creation Date: July 21, 2025

setlocal enabledelayedexpansion
title Automatic Restart Script

REM ========================================
REM           Configuration Block
REM ========================================
set "COUNT_FILE=C:\Windows\Temp\auto_restart_count.txt"
set "LOG_FILE=C:\Windows\Temp\auto_restart_log.txt"
set "COUNTDOWN_SECONDS=180"
set "SHUTDOWN_DELAY_SECONDS=5"
REM ========================================

REM Check Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges to perform restart operations.
    echo Please run this script as an administrator.
    pause
    exit /b 1
)

REM Initialize restart count
if not exist "%COUNT_FILE%" (
    echo 0 > "%COUNT_FILE%"
)

REM Read current restart count
set /p restart_count=<"%COUNT_FILE%"
set /a restart_count=!restart_count! + 1
echo !restart_count! > "%COUNT_FILE%"

echo.
echo ========================================
echo        Automatic Restart Script
echo ========================================
echo.
echo The system will automatically restart in %COUNTDOWN_SECONDS%/60 minutes %COUNTDOWN_SECONDS%%%60 seconds.
echo If you wish to cancel, press Ctrl+C during the countdown.
echo.

REM Countdown
for /L %%i in (%COUNTDOWN_SECONDS%,-1,1) do (
    set /a minutes=%%i/60
    set /a seconds=%%i%%60
    echo Remaining time: !minutes! min !seconds! sec
    timeout /t 1 /nobreak >nul
)

echo.
echo Preparing to restart...

REM Log Restart Time
echo [%date% %time%] Restart count: !restart_count!
echo [%date% %time%] Restart count: !restart_count! >> "%LOG_FILE%"

REM Execute Restart
shutdown /r /t %SHUTDOWN_DELAY_SECONDS% /c "Automatic Restart Script - The system will restart in %SHUTDOWN_DELAY_SECONDS% seconds."
echo The restart command has been executed, the system will restart in %SHUTDOWN_DELAY_SECONDS% seconds....
timeout /t %SHUTDOWN_DELAY_SECONDS% /nobreak >nul