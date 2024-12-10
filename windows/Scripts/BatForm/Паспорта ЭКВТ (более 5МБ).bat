echo off 
COLOR 2

Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%

set cur_dir=%f_Year%\%f_Month%\%f_Day%
set archiv=L:\arhiv_obmen\FTS\%cur_dir%
set DC=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\DC_EI\DC\%cur_dir%
set DC_KA=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\DC_EI\DC_KA\%cur_dir%
set DC_ARJ=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\DC_EI\DC_ARJ\%cur_dir%

md %archiv%

echo 1. Коприуем PDF-файлы из DC в архив
COPY %DC%\*.pdf %archiv%

echo 2. Копируем PDF-файлы из DC в каталог для подписания/зашифровки
MOVE %DC%\*.pdf C:\FS_TEMP\OUT\

echo 3. Выполняем подписывание PDF-файлов!!!
copy C:\Auto\Podpis\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

"C:\Program Files\MDPREI\РМП Верба-OW\FColseOW.exe" /@"C:\Auto\SIGN.skr"

echo 4. Перемещаем файлы в каталог DC_KA
MOVE C:\FS_TEMP\OUT\*.* %DC_KA%

echo Первый этап сделан
pause 

echo 6. Копируем файл многотомного архива из DC_KA-v5000 в каталог для подписания
COPY %DC_ARJ%\*.arj C:\FS_TEMP\OUT\

echo 6. Выполняем шифрование многотомных архивов!!!
copy C:\Auto\Shifr\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

"C:\Program Files\MDPREI\РМП Верба-OW\FColseOW.exe" /@"C:\Auto\Crypt.skr"

copy C:\Auto\norm\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

echo 5. Перемещаем файлы в каталог DC_KA
MOVE C:\FS_TEMP\OUT\*.* %DC_KA%

echo Первый этап сделан
pause 
echo Как она сделает второй продолжаем
pause

echo 6. Копируем архивный файл из DC_ARJ в каталог для подписания
COPY %DC_ARJ%\*.arj C:\FS_TEMP\OUT\

echo 7. Выполняем подписывание архивного файла!!!
copy C:\Auto\Podpis\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

"C:\Program Files\MDPREI\РМП Верба-OW\FColseOW.exe" /@"C:\Auto\SIGN.skr"

copy C:\Auto\norm\FColseOW.INI "C:\Documents and Settings\Ptkpsd\Application Data\MDPREI\РМП Верба-OW"

echo 8. Копируем подписанный архивный файл в архив
COPY C:\FS_TEMP\OUT\*.arj %archiv%

echo 9. Перемещаем файл в MailBox до завтра
MOVE C:\FS_TEMP\OUT\*.arj H:\fts\

echo Второй сделан, отправка завтра
pause