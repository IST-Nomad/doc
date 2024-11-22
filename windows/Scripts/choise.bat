@echo off
chcp 65001
:menu
echo.
echo Выберите, какой файл .bat запустить:
echo 1 - 1.bat
echo 2 - 2.bat
echo 3 - 3.bat
echo Q - Выход
set /p choice="Введите номер или Q для выхода: "

rem Обработка выбора пользователя
if /i "%choice%"=="1" (
    call 1.bat
) else if /i "%choice%"=="2" (
    call 2.bat
) else if /i "%choice%"=="3" (
    call 3.bat
) else if /i "%choice%"=="Q" (
    echo Выход...
    exit /b
) else (
    echo Неверный ввод. Пожалуйста, выберите 1, 2, 3 или Q.
)

rem Возврат в меню после выполнения выбранного файла
goto menu