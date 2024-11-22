@echo off
rem Таймауты проставил на всякий случай
color 2
rem Выключаем новые подключения
change logon /disable
rem Отключаем всех пользователей кроме тех что указаны в скрипте (админы)
powershell -file C:\Scripts\killproc_WFinist.ps1
rem Копируем конфиг
copy "C:\Finist\WFinInst\finistbank.dsn" C:\Finist\config_wfinist
copy "C:\Finist\WFinInst\Wfinist.ini" C:\Finist\config_wfinist
rem Удаляем папки со всем содержимым
RMDIR \\FINIST-TERMINAL\c$\Finist\WFinInst /S /Q 

rem Копируем с боевого сервера в тестовые папки всё кроме конфигов

robocopy \\FINIST\c$\Finist\WFinInst \\FINIST-TERMINAL\c$\Finist\WFinInst /E /R:1 /W:0 
copy "C:\Finist\config_wfinist\finistbank.dsn" C:\Finist\WFinInst\
copy "C:\Finist\config_wfinist\Wfinist.ini" C:\Finist\WFinInst\


rem Включаем новые подключения
change logon /enable