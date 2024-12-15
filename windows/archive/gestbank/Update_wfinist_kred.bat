@echo off

color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копирования
powershell -file C:\Scripts\killproc_WFinist.ps1
rem Копируем конфиги
copy "C:\Kredit\WFinInst\finistbank.dsn" C:\Kredit\config_wfinist
copy "C:\Kredit\WFinInst\Wfinist.ini" C:\Kredit\config_wfinist
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Kredit\WFinInst /S /Q 
rem Копируем с тестового сервера клиентскую папку
robocopy \\FINIST-TEST\c$\Finist\WFinInst \\GESTBANK\c$\Kredit\WFinInst /E /R:1 /W:0 
rem копируем старый конфиги
copy "C:\Kredit\config_wfinist\finistbank.dsn" C:\Kredit\WFinInst\
copy "C:\Kredit\config_wfinist\Wfinist.ini" C:\Kredit\WFinInst\
rem Включаем новые подключения
change logon /enable