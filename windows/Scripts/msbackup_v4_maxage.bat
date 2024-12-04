@echo off
setlocal

:: Установка путей
set "source=\\FINIST\c$\Backup\Full_backup"
set "destination=\\BKS\FINIST_backup"
set "logFile=C:\Backup\copy_backup.txt"

:: Установка максимального числа попыток
set "maxAttempts=3"
set "attempt=1"

:: Флаг успешного копирования
set "copySuccess=0"

:: Запись времени начала копирования в лог
echo %date% %time% Copy_backup_start_test >> "%logFile%"

:copyLoop
robocopy "%source%" "%destination%" /E /MAXAGE:1 /R:3 /W:0
set "robocopyExit=%ERRORLEVEL%"

:: Проверка кода возврата
if %robocopyExit% EQU 0 (
    echo %date% %time% Copy_backup_success_end >> "%logFile%"
    set "copySuccess=1"
) else (
    echo %date% %time% Copy_backup_failure_attempt_%attempt% >> "%logFile%"

    :: Проверка, достигнуто ли максимальное число попыток
    if %attempt% LSS %maxAttempts% (
        set /a attempt+=1
        echo Attempt %attempt% of %maxAttempts% failed. Retrying in 5 seconds...
        timeout /t 5 /nobreak >nul  :: Задержка на 5 секунд
        goto copyLoop
    ) else (
        echo %date% %time% Copy_backup_failed_final >> "%logFile%"
    )
)

endlocal