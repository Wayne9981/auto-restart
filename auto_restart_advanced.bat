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
REM MAX_RESTART_COUNT: Maximum number of restarts allowed (set to 0 for unlimited)
set "MAX_RESTART_COUNT=10"
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

REM Check maximum restart count (only if MAX_RESTART_COUNT > 0)
if %MAX_RESTART_COUNT% gtr 0 (
    if !restart_count! gtr %MAX_RESTART_COUNT% (
        echo.
        echo ========================================
        echo      Maximum Restart Limit Reached
        echo ========================================
        echo Maximum restart count %MAX_RESTART_COUNT% has been reached.
        echo Script will now exit to prevent infinite restart loop.
        echo.
        echo ========================================
        echo            Reset Instructions
        echo ========================================
        echo To reset the restart counter, you can:
        echo Delete the count file: del "%COUNT_FILE%"
        echo.
        echo To remove this script completely:
        echo 1. Delete the script file: del "%~f0"
        echo 2. Delete the log file: del "%LOG_FILE%"
        echo 3. Delete the count file: del "%COUNT_FILE%"
        echo 4. Check and remove from Windows Task Scheduler if installed:
        echo    - Open "Task Scheduler" ^(taskschd.msc^)
        echo    - Look for tasks related to this script
        echo    - Delete any auto-restart related tasks
        echo.
        echo Press any key to exit...
        echo [%date% %time%] Max restart limit reached: %MAX_RESTART_COUNT% >> "%LOG_FILE%"
        pause
        exit /b 0
    )
)

echo.
echo ========================================
echo        Automatic Restart Script
echo ========================================
if %MAX_RESTART_COUNT% gtr 0 (
    echo Current restart count: !restart_count! / %MAX_RESTART_COUNT%
) else (
    echo Current restart count: !restart_count! ^(no limit^)
)
echo.
set /a c_min=%COUNTDOWN_SECONDS%/60
set /a c_sec=%COUNTDOWN_SECONDS%%%60
echo The system will automatically restart in %c_min% minutes %c_sec% seconds.
echo If you wish to cancel, press Ctrl+C during the countdown.
echo.

REM Countdown
for /f %%a in ('powershell "[char]13"') do set "R=%%a"
for /L %%i in (%COUNTDOWN_SECONDS%,-1,1) do (
    set /a minutes=%%i/60
    set /a seconds=%%i%%60
    set /p="Remaining time: !minutes! min !seconds! sec   !R!" <nul
    timeout /t 1 /nobreak >nul
)

echo.
echo Preparing to restart...

REM Log Restart Time
echo [%date% %time%] Restart count: !restart_count! >> "%LOG_FILE%"
echo !restart_count! > "%COUNT_FILE%"

REM Execute Restart
shutdown /r /t %SHUTDOWN_DELAY_SECONDS% /c "Automatic Restart Script - The system will restart in %SHUTDOWN_DELAY_SECONDS% seconds."
echo The restart command has been executed, the system will restart in %SHUTDOWN_DELAY_SECONDS% seconds....
timeout /t %SHUTDOWN_DELAY_SECONDS% /nobreak >nul