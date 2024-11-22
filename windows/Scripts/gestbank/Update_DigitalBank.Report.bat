@echo off

color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копирования
powershell -file c:\Scripts\killproc_FinistDigitalBank.Report.UserArm.ps1
rem Копируем конфиг
copy "C:\Finist\FinistDigitalBank.Report\FinistDigitalBank.Report.UserArm.exe.config" C:\Finist\config_DigitalReport
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Finist\FinistDigitalBank.Report /S /Q 
rem Копируем с тестового сервера клиентскую папку
robocopy \\FINIST-TRANS\c$\Finist\FinistDigitalBank.Report\Client \\GESTBANK\c$\Finist\FinistDigitalBank.Report /E /R:1 /W:0
rem копируем старый конфиг 
copy "C:\Finist\config_DigitalReport\FinistDigitalBank.Report.UserArm.exe.config" C:\Finist\FinistDigitalBank.Report
rem Включаем новые подключения
change logon /enable