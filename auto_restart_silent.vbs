' VBScript 版本的自動重開機腳本
' 可在背景執行，不顯示命令視窗
' 作者：自動生成
' 建立日期：2025年7月21日

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' 記錄檔路徑
logFile = "C:\Windows\Temp\auto_restart_vbs_log.txt"

' 記錄開始時間
startTime = Now()
logEntry = "VBScript 自動重開機腳本啟動：" & startTime & vbCrLf

' 寫入記錄檔
If objFSO.FileExists(logFile) Then
    Set objFile = objFSO.OpenTextFile(logFile, 8) ' 8 = ForAppending
Else
    Set objFile = objFSO.CreateTextFile(logFile)
End If
objFile.Write(logEntry)
objFile.Close

' 等待 3 分鐘 (180000 毫秒)
WScript.Sleep(180000)

' 記錄重開機時間
restartTime = Now()
logEntry = "執行重開機命令：" & restartTime & vbCrLf

Set objFile = objFSO.OpenTextFile(logFile, 8)
objFile.Write(logEntry)
objFile.Close

' 執行重開機命令
objShell.Run "shutdown /r /t 0 /c ""VBScript 自動重開機腳本執行完成""", 0, False

' 清理物件
Set objShell = Nothing
Set objFSO = Nothing
Set objFile = Nothing
