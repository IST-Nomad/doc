@echo off
set "name=DeltaReport"
set "logFile=\\FINIST\c$\Scripts\log\update_app.txt"
set "source=\\FINIST\c$\Finist\%name%"
set "destination=\\FINIST-TERMINAL\c$\Finist\%name%"
set "config_file1=connection.ini"
set "config_file12=DeltaReport.exe.Config"
set "config_dir=\\FINIST-TERMINAL\c$\Finist\config_%name%"
color 2
:: Выключаем новые подключения
change logon /disable
:: Гасим службу у всех пользователей
powershell -file C:\Scripts\killproc_%name%.ps1
TIMEOUT 5
:: Копируем конфиг
copy "%destination%\%config_file1%" %config_dir%
copy "%destination%\%config_file2%" %config_dir%
:: Удаляем папки со всем содержимым
RMDIR %destination% /S /Q 
:: Копируем с боевого сервера в тестовые папки всё кроме конфигов
robocopy %source% %destination% /E /R:1 /W:0 
copy "%config_dir%\%config_file1%" %destination%
copy "%config_dir%\%config_file2%" %destination%
echo %date% %time% Update_%name%_success to FINIST-TERMINAL >> "%logFile%"
:: Включаем новые подключения
change logon /enable