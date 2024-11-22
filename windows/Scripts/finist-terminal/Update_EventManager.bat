@echo off
rem Таймауты проставил на всякий случай
color 2
change logon /disable
powershell -file C:\Scripts\killproc_EventManager.UserArm.ps1
copy "C:\Finist\EventManager\UserArm\EventManager.UserArm.dll.config" C:\Finist\config_eventmanager
rem Удаляем папки со всем содержимым
RMDIR \\FINIST-TERMINAL\c$\Finist\EventManager\UserArm /S /Q 
rem Копируем с тестового сервера в тестовые папки
robocopy \\FINIST\c$\Finist\EventManager\UserArm \\FINIST-TERMINAL\c$\Finist\EventManager\UserArm /E /R:1 /W:0
copy "C:\Finist\config_eventmanager\EventManager.UserArm.dll.config" C:\Finist\EventManager\UserArm
change logon /enable