echo off 
COLOR 2

Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,4%

set archiv=L:\arhiv_obmen\FTS\1459\%f_Year%\%f_Month%\%f_Day%
set ESDT=L:\TBSVK\RVK_Kontrakt_3_0\IZ_FTS\406FZ\ESDT\


echo как она сделает Второй нажмём, Начнется Третий этап 
pause


echo off 
COLOR 2

Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%


set KVIT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KVIT\%f_Year%\%f_Month%\%f_Day%
 set KESDT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KESDT\%f_Year%\%f_Month%\%f_Day%

rem set KVIT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KVIT\2014\09\30
rem KESDT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KESDT\2014\09\30

echo 1. Перемещаем файлы из KVIT в каталог для шифровки
MOVE %KVIT%\*.* C:\FS_TEMP\OUT\

echo 2. Выполняем подписывание квитанций xml!!!
copy C:\Auto\Podpis\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

"C:\Program Files\MDPREI\РМП Верба-OW\FColseOW.exe" /@"C:\Auto\SIGN.skr"

echo 3. Перемещаем файлы в KESDT
MOVE C:\FS_TEMP\OUT\*.* %KESDT%

echo Говорим что Третий этап сделан
pause 
echo как она сделает Третий нажмём, Начнется Четвертый этап 
pause

echo off 
COLOR 2

Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%

set KESDT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KESDT\%f_Year%\%f_Month%\%f_Day%
set archiv=l:\FTS\1459\%f_Year%\%f_Month%\%f_Day%

echo 1. Перемещаем архивный файл из KESDT в каталог для подписания
ping localhost -n 10
MOVE %KESDT%\KESDT*.arj C:\FS_TEMP\OUT\

echo 2. Выполняем подписывание архивного файла!!!
copy C:\Auto\Podpis\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

"C:\Program Files\MDPREI\РМП Верба-OW\FColseOW.exe" /@"C:\Auto\SIGN.skr"

copy C:\Auto\norm\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

echo 3. Копируем подписанный архивный файл в архив
COPY C:\FS_TEMP\OUT\KESDT*.arj %archiv%

echo 4. Перемещаем файл в каталог на отправку
MOVE C:\FS_TEMP\OUT\KESDT*.arj \\10.129.135.238\ObmenPTK\OutFS

pause
