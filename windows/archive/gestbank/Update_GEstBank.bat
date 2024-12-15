@echo off
set "name=GEstBank"
set "logFile=\\FINIST\c$\Scripts\log\update_app.txt"
set "source=\\FINIST-TRANS\c$\Finist\%name%\Client_Pre"
set "destination=\\GESTBANK\c$\Finist\Client"
set "config_file1=GEstBank.UserARM.dll.config"

set "config_dir=\\GESTBANK\c$\Finist\config_%name%"
color 2
:: Выключаем новые подключения
change logon /disable
:: Гасим службу у всех пользователей
powershell -file C:\Scripts\killproc_%name%.ps1
TIMEOUT 5
:: Копируем конфиг
copy "%destination%\%config_file1%" %config_dir%

:: Удаляем папки со всем содержимым
RMDIR %destination% /S /Q 
:: Копируем с боевого сервера в тестовые папки всё кроме конфигов
robocopy %source% %destination% /E /R:1 /W:0 
copy "%config_dir%\%config_file1%" %destination%

echo %date% %time% Update_%name%_success  to GESTBANK >> "%logFile%"
:: Включаем новые подключения
change logon /enable