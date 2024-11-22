@echo off
rem Таймауты проставил на всякий случай
color 2
rem Выключаем новые подключения
change logon /disable

rem Отключаем всех пользователей кроме тех что указаны в скрипте (админы)
powershell -file C:\Scripts\killproc_FinistReport.UserArm.ps1

rem Копируем конфиг
copy "C:\Finist\FinistReportIFRS9\FinistReport.Client\FinistReport.UserArm.exe.config" C:\Finist\config_FinistReport

rem Удаляем папки со всем содержимым
RMDIR \\FINIST-TERMINAL\c$\Finist\FinistReportIFRS9\FinistReport.Client /S /Q 


rem Копируем с боевого сервера в тестовые папки всё кроме конфигов

robocopy \\finist\c$\Finist\FinistReportIFRS9\FinistReport.Client C:\Finist\FinistReportIFRS9\FinistReport.Client /E /R:1 /W:0 
copy "C:\Finist\config_FinistReport\FinistReport.UserArm.exe.config" C:\Finist\FinistReportIFRS9\FinistReport.Client\



rem Включаем новые подключения
change logon /enable