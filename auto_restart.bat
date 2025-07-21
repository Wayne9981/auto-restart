@echo off
REM Auto Restart Script - Executes after a delay
REM Author: Auto-generated
REM Created on: July 21, 2025

REM === Configuration ===
set "WAIT_SECONDS=30"
REM =====================

echo The system will automatically restart in %WAIT_SECONDS% seconds...
echo Start time: %date% %time% >> C:\Windows\Temp\auto_restart_log.txt

REM Wait for the specified number of seconds
timeout /t %WAIT_SECONDS% /nobreak

REM Log the restart time
echo Restart time: %date% %time% >> C:\Windows\Temp\auto_restart_log.txt

REM Execute the restart command
shutdown /r /t 0 /c "Auto restart script executed"

pause