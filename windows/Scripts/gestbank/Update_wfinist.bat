@echo off

color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копирования
powershell -file C:\Scripts\killproc_WFinist.ps1
rem Копируем конфиги
copy "C:\Finist\WFinInst\finistbank.dsn" C:\Finist\config_wfinist
copy "C:\Finist\WFinInst\Wfinist.ini" C:\Finist\config_wfinist
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Finist\WFinInst /S /Q 
rem Копируем с тестового сервера клиентскую папку
robocopy \\FINIST-TRANS\c$\Finist\WFinInst \\GESTBANK\c$\Finist\WFinInst /E /R:1 /W:0 
rem копируем старый конфиги
copy "C:\Finist\config_wfinist\finistbank.dsn" C:\Finist\WFinInst\
copy "C:\Finist\config_wfinist\Wfinist.ini" C:\Finist\WFinInst\
rem Включаем новые подключения
change logon /enable