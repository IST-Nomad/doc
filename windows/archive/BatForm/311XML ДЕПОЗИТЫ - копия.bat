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
Set m_Year=%f_Date:~8,2%

set dir_in=H:\no_XML\out
set dir_out=c:\ObmenPTK\OutFS
set dir_work=c:\FOIV_temp\FNS_311p\Out
set dir_arch=L:\arhiv_obmen\nalog\fz311xml\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

set xml_files=SBC*1?????_?00.xml

md %dir_arch%

echo 1. Делаем копию файлов
COPY %dir_in%\%xml_files% %dir_arch%

echo 3. Переносим подготовленные файлы в папку для зашифровки
MOVE %dir_in%\%xml_files% %dir_work%

echo 4. Подписываем и шифруем через ПТК - Настройка 01 - СКАД Сигнатура!
echo    Нажимаем "Постановка КА и шифрование"
pause
echo Подписали?
pause
echo Деинициализируем ключ!
pause

Set f_Date=%Date%
Set m_Year=%f_Date:~8,2%

echo 5.1. Проверка на повторение номера архива
set Fname=1
:start1
if exist %dir_arch%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj (
set /a Fname=Fname + 1
goto :start1 )

echo 6. Подготавливаем архив
arj32.exe a -e %dir_work%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj %dir_work%\%xml_files%

echo 7. Удаляем файлы архива
DEL %dir_work%\%xml_files%

echo 8. Копируем  Архив
COPY %dir_work%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj %dir_arch%

echo 9. Отправляем!!!
MOVE %dir_work%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj %dir_out%

pause