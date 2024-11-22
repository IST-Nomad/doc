@echo off
rem Таймауты проставил на всякий случай
color 2
rem Выключаем новые подключения
change logon /disable
rem TIMEOUT 5
rem Отключаем всех пользователей кроме тех что указаны в скрипте (админы)
powershell -file C:\Scripts\killproc_DH_Report.ps1
rem TIMEOUT 5
rem Копируем конфиг
rem copy "C:\Finist\WFinInst\finistbank.dsn" C:\Finist\config_wfinist
rem copy "C:\Finist\WFinInst\Wfinist.ini" C:\Finist\config_wfinist
rem Удаляем папки со всем содержимым
RMDIR \\FINIST-TERMINAL\c$\Finist\DH_Report /S /Q 

rem TIMEOUT 5
rem Копируем с боевого сервера в тестовые папки всё кроме конфигов

robocopy \\FINIST\c$\Finist\DH_Report \\FINIST-TERMINAL\c$\Finist\DH_Report /E /R:1 /W:0 
rem copy "C:\Finist\config_wfinist\finistbank.dsn" C:\Finist\WFinInst\
rem copy "C:\Finist\config_wfinist\Wfinist.ini" C:\Finist\WFinInst\


rem Включаем новые подключения
change logon /enable