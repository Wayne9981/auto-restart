@echo off
REM Auto Restart Script - Executes after a delay
REM Author: Auto-generated
REM Created on: July 21, 2025

echo The system will automatically restart in 3 minutes...
echo Start time: %date% %time% >> C:\Windows\Temp\auto_restart_log.txt

REM Wait for 180 seconds (3 minutes)
timeout /t 180 /nobreak

REM Log the restart time
echo Restart time: %date% %time% >> C:\Windows\Temp\auto_restart_log.txt

REM Execute the restart command
shutdown /r /t 0 /c "Auto restart script executed"
