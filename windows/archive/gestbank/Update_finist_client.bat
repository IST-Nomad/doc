@echo off
color 2
chcp 65001
:menu
echo.
echo Выберите, какой клиент слудует обновить 
echo Перед выполнением оповести пользователей что сеанс работы в клиенте завершится автоматически!!!
echo 1 - Обновить DH_Report
echo 2 - Обновить DigitalBank.Report
echo 3 - Обновить EventManager
echo 4 - Обновить GEstBank
echo 5 - Обновить ReportIFRS9
echo 6 - Обновить wfinist
echo 7 - Обновить GEstBank_kred
echo 8 - Обновить wfinist_kred
echo Q - Выход
set /p choice="Введите номер или Q для выхода: "

rem Обработка выбора пользователя
if /i "%choice%"=="1" (
    call C:\Scripts\Update_DH_Report.bat
) else if /i "%choice%"=="2" (
    call C:\Scripts\Update_DigitalBank.Report.bat
) else if /i "%choice%"=="3" (
    call C:\Scripts\Update_EventManager.bat
) else if /i "%choice%"=="4" (
    call C:\Scripts\Update_GEstBank.bat
) else if /i "%choice%"=="5" (
    call C:\Scripts\Update_ReportIFRS9.bat
) else if /i "%choice%"=="6" (
    call C:\Scripts\Update_wfinist.bat
) else if /i "%choice%"=="7" (
    call C:\Scripts\Update_GEstBank_kred.bat
) else if /i "%choice%"=="8" (
    call C:\Scripts\Update_wfinist_kred.bat
) else if /i "%choice%"=="Q" (
    echo Выход...
    exit /b
) else (
    echo ПО РУССКИ НАПИСАНО! выберите 1, 2, 3, 4, 5, 6 или Q.
)

rem Возврат в меню после выполнения выбранного файла
goto menu