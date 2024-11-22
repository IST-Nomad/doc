@echo off

color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копирования
powershell -file C:\Scripts\killproc_EventManager.UserArm.ps1
copy "C:\Finist\EventManager\UserArm\EventManager.UserArm.dll.config" C:\Finist\config_eventmanager
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Finist\EventManager\UserArm /S /Q 
rem Копируем с тестового сервера клиентскую папку
robocopy \\FINIST-TRANS\c$\Finist\EventManager\UserArm \\GESTBANK\c$\Finist\EventManager\UserArm /E /R:1 /W:0
rem копируем старый конфиг
copy "C:\Finist\config_eventmanager\EventManager.UserArm.dll.config" C:\Finist\EventManager\UserArm
rem Включаем новые подключения
change logon /enable