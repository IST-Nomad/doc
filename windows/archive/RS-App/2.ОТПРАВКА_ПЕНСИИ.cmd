Setlocal EnableDelayedExpansion
echo off
COLOR 2

::Переменные из даты для работы
Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,2%

::Откуда забираем (выходная директория для RS)
set dir_find=L:\PFR\Out

::Куда ложим
set dir_out=L:\PFR\Outbox

::читаем файл numb_send для нумерации каталога
set /p NUM="" < L:\PFR\numb_send.txt
set /p file_name="" < L:\PFR\files.txt

::записываем файл numb_send следующий номер
set /a NUM_NEXT=%NUM%+1
echo %NUM_NEXT%> "L:\PFR\numb_send.txt"

::Создаем каталог в out с номером по порядку
set dir_arch=%dir_find%\%NUM%
md %dir_arch%

::перемещаем в созданный каталог из out
move %dir_find%\*.xml %dir_arch%

::Переходим в каталог архива
cd %dir_arch%

::Записываем имя файла POSD
dir *POSD*.xml /b > out_xml.txt
::Создаем первый архивный файл (имя архива временное)
L:\Utils\7z.exe a -tzip temp_name1.zip -i@out_xml.txt

::Переименовываем архив
::ren temp_name1.zip 004p%file_name:~4,2%%NUM%.048
ren temp_name1.zip 048p%file_name:~4,2%%NUM%.004

timeout 1

::Записываем имя файла OPVF и OZAC
dir *OPVF*.xml /b > out_xml.txt
dir *OZAC*.xml /b >> out_xml.txt

::Создаем второй архивный файл (имя архива временное)
L:\Utils\7z.exe a -tzip temp_name2.zip -i@out_xml.txt

::Переименовываем архив
::ren temp_name2.zip 004a%file_name:~4,2%%NUM%.048
ren temp_name2.zip 048a%file_name:~4,2%%NUM%.004

timeout 1

::Удаляем временный файл out_xml.txt
del out_xml.txt \Q

::перемещаем архивные файлы в созданный каталог из out
::copy %dir_arch%\*.048 %dir_out%
copy %dir_arch%\*.004 %dir_out%
move  %dir_out%\*.xml %dir_arch%
pause