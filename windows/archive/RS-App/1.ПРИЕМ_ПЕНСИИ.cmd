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

::Директория архива (бэкапа)
set dir_arch=L:\PFR\In\arh\%f_Year%%f_Month%%f_Day%

::Куда ложим (входная директория для Finist)
set dir_in=L:\PFR\In

::Откуда забираем
set dir_find=L:\PFR\Inbox

set file_tmp=L:\PFR\files.txt

::Создаем каталог в arh с текущей датой
md %dir_arch%

::Имена всех найденных файлов записываем в список
dir %dir_find%\*.048 /b > =L:\PFR\files.txt

::Т.к. обработка одновременно нескольких архивов запрещена
::то запускаем цикл для каждого найденного файла
SET FL=
for /f "eol=" %%i in (L:\PFR\files.txt) do (
SET FL=%%i

::копируем в In
copy %dir_find%\!FL! %dir_arch%

::Распаковываем архивный файлe
L:\Utils\7z.exe x %dir_find%\!FL2! -o%dir_in%

del %dir_find%\*.* /Q
)
::Конец цикла
pause