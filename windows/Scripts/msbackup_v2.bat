@echo off
setlocal

:: Установка путей
set "source=\\FINIST\c$\Backup\Full_backup"
set "destination=\\BKS\FINIST_backup"
set "logFile=C:\Backup\copy_backup.txt"

:: Запись времени начала копирования в лог
echo %date% %time% Copy_backup_start_test >> "%logFile%"

:: Выполнение команды robocopy и сохранение кода возврата
robocopy "%source%" "%destination%" /E /R:3 /W:0
set "robocopyExit=%ERRORLEVEL%"

:: Проверка кода возврата и запись в лог
if %robocopyExit% EQU 0 (
    echo %date% %time% Copy_backup_success_end >> "%logFile%"
) else (
    echo %date% %time% Copy_backup_error_end >> "%logFile%"
)

endlocal