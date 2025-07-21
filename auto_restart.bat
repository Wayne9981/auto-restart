@echo off
REM 自動重開機腳本 - 開機後三分鐘執行
REM 作者：自動生成
REM 建立日期：2025年7月21日

echo 系統將在3分鐘後自動重開機...
echo 開始時間：%date% %time%

REM 等待180秒（3分鐘）
timeout /t 180 /nobreak

REM 記錄重開機時間
echo 重開機時間：%date% %time% >> C:\Windows\Temp\auto_restart_log.txt

REM 執行重開機命令
shutdown /r /t 0 /c "自動重開機腳本執行完成"
