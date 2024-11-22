@echo off
rem Таймауты проставил на всякий случай
color 2
rem Выключаем новые подключения
change logon /disable
rem Отключаем всех пользователей кроме тех что указаны в скрипте (админы)
powershell -file C:\Scripts\killproc_GEstBank.UserARM.ps1
TIMEOUT 5
rem Копируем конфиг
copy "C:\Finist\Client\GEstBank.UserARM.dll.config" C:\Finist\config_gest
rem Удаляем папки со всем содержимым
RMDIR \\FINIST-TERMINAL\c$\Finist\Client /S /Q 
rem Копируем с боевого сервера в тестовые папки всё кроме конфигов
robocopy \\FINIST\c$\Finist\GEstBank\Client \\FINIST-TERMINAL\c$\Finist\Client /E /R:1 /W:0 
copy "C:\Finist\config_gest\GEstBank.UserARM.dll.config" C:\Finist\Client\

rem Включаем новые подключения
change logon /enable