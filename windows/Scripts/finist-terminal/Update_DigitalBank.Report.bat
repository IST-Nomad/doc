@echo off
rem Таймауты проставил на всякий случай
color 2
rem Выключаем новые подключения
change logon /disable
rem Отключаем всех пользователей кроме тех что указаны в скрипте (админы)
powershell -file c:\Scripts\killproc_FinistDigitalBank.Report.UserArm.ps1
rem Копируем конфиг
copy "C:\Finist\FinistDigitalBank.Report\FinistDigitalBank.Report.UserArm.exe.config" C:\Finist\config_DigitalReport
rem Удаляем папки со всем содержимым
RMDIR \\FINIST-TERMINAL\c$\Finist\FinistDigitalBank.Report /S /Q 
rem Копируем с боевого сервера в тестовые папки всё кроме конфигов
robocopy \\FINIST\c$\Finist\FinistDigitalBank.Report\Client \\FINIST-TERMINAL\c$\Finist\FinistDigitalBank.Report /E /R:1 /W:0 
copy "C:\Finist\config_DigitalReport\FinistDigitalBank.Report.UserArm.exe.config" C:\Finist\FinistDigitalBank.Report



rem Включаем новые подключения
change logon /enable