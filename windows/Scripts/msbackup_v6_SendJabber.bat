@echo off
chcp 65001
setlocal

:: Установка путей
set "source=\\FINIST\c$\Backup\Full_backup"
set "baseDestination=\\BKS\FINIST_backup"
set "logFile=C:\Backup\result_copy_backup.txt"

Set f_Date=%Date%
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2%
Set f_Month=%f_Date:~3,2%
Set f_Year=%f_Date:~6,4%
Set f_Hour=%Time:~0,5%

Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
:: Получение текущей даты
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (
    set "currentDate=%f_Year%_%f_Month%_%f_Day%"  :: Форматируем дату как ГГГГ_ММ_ДД
)

:: Установка полного пути назначения
set "destination=%baseDestination%\%currentDate%"

:: Создание директории с текущей датой, если она не существует
if not exist "%destination%" (
    mkdir "%destination%"
)

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
	C:\Scripts\SendJabber.exe  backup@jabber.tcbdomen.trustcombank.ru backup 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "FINIST Full_backup скопирован на BKS успешно"
	timeout 2 /nobreak
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
		C:\Scripts\SendJabber.exe  backup@jabber.tcbdomen.trustcombank.ru backup 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "FINIST Full_backup не скопирован на BKS"
		timeout 2 /nobreak
    )
)

endlocal