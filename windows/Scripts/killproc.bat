@echo off
setlocal

:: Укажите имя процесса, который нужно завершить
set "PROCESS_NAME=notepad++.exe"

echo Завершение процесса %PROCESS_NAME% для всех активных сессий...

:: Получаем список всех пользователей
for /f "tokens=1" %%u in ('query user ^| findstr /i "Active"') do (
    echo Проверка процессов пользователя %%u...
    rem Завершение процессов для каждого активного пользователя
    for /f "tokens=1" %%p in ('tasklist ^| findstr /i "%PROCESS_NAME%" ^| findstr /i "%%u"') do (
        echo Завершение процесса %PROCESS_NAME% (PID: %%p) для пользователя %%u...
        taskkill /PID %%p /F
    )
)

echo Процесс %PROCESS_NAME% завершен для всех активных сессий.
endlocal