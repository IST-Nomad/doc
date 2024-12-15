@echo off
color 2
chcp 65001
:menu
echo.
echo Выберите, какой процесс убить
echo Перед выполнением оповести пользователей что сеанс работы в клиенте завершится автоматически!!!
echo 1 - Убить DH_Report
echo 2 - Убить DigitalBank.Report
echo 3 - Убить EventManager
echo 4 - Убить GEstBank
echo 5 - Убить ReportIFRS9
echo 6 - Убить wfinist
echo Q - Выход
set /p choice="Введите номер или Q для выхода: "

rem Обработка выбора пользователя
if /i "%choice%"=="1" (
    powershell -file C:\Scripts\killproc_DH_Report.ps1
) else if /i "%choice%"=="2" (
    powershell -file C:\Scripts\killproc_FinistDigitalBank.Report.UserArm.ps1
) else if /i "%choice%"=="3" (
    powershell -file C:\Scripts\killproc_EventManager.UserArm.ps1
) else if /i "%choice%"=="4" (
    powershell -file C:\Scripts\killproc_GEstBank.UserARM.ps1
) else if /i "%choice%"=="5" (
    powershell -file C:\Scripts\killproc_FinistReport.UserArm.ps1
) else if /i "%choice%"=="6" (
    powershell -file C:\Scripts\killproc_WFinist.ps1
) else if /i "%choice%"=="Q" (
    echo Выход...
    exit /b
) else (
    echo ПО РУССКИ НАПИСАНО! выберите 1, 2, 3, 4, 5, 6 или Q.
)

rem Возврат в меню после выполнения выбранного файла
goto menu