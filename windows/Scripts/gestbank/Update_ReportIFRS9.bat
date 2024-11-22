@echo off

color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копирования
powershell -file C:\Scripts\killproc_FinistReport.UserArm.ps1
rem Копируем конфиг
copy "C:\Finist\FinistReportIFRS9\FinistReport.Client\FinistReport.UserArm.exe.config" C:\Finist\config_FinistReport
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Finist\FinistReportIFRS9\FinistReport.Client /S /Q 
rem Копируем с тестового сервера клиентскую папку
robocopy \\FINIST-TRANS\c$\Finist\FinistReportIFRS9\FinistReport.Client \\GESTBANK\c$\Finist\FinistReportIFRS9\FinistReport.Client /E /R:1 /W:0 
rem копируем старый конфиг
copy "C:\Finist\config_FinistReport\FinistReport.UserArm.exe.config" C:\Finist\FinistReportIFRS9\FinistReport.Client\
rem Включаем новые подключения
change logon /enable