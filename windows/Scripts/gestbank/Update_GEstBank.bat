@echo off

color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копирования
powershell -file C:\Scripts\killproc_GEstBank.UserARM.ps1
rem Копируем конфиг
copy "C:\Finist\Client\GEstBank.UserARM.dll.config" C:\Finist\config_gest
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Finist\Client /S /Q 
rem Копируем с тестового сервера клиентскую папку
robocopy \\FINIST-TRANS\c$\Finist\GEstBank\Client_Pre \\GESTBANK\c$\Finist\Client /E /R:1 /W:0 
rem копируем старый конфиг
copy "C:\Finist\config_gest\GEstBank.UserARM.dll.config" C:\Finist\Client\
rem Включаем новые подключения
change logon /enable