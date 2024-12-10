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

::Set f_Day=24

::Директория arhiv_obmen
set dir_arch=l:\arhiv_obmen\КФМ\407P\%f_Year%\%f_Month%\%f_Day%

::Директория FS_temp
set dir_temp=c:\FS_temp\

::Переносим квитанции во временный каталог
MOVE %dir_arch%\PI_*.xml %dir_temp%
MOVE %dir_arch%\NI_*.xml %dir_temp%

::Имена всех квитанций записываем в список
dir %dir_temp%\*.xml /b /s > c:\files_for_sign.txt
pause

::Снимаем КА со всех файлов
scsignex.exe -r -ia:\ -ga:\ -oc:\Auto\log_file.txt -lc:\files_for_sign.txt

::Переносим квитанции обратно в каталог архива
MOVE %dir_temp%\*.xml %dir_arch%

echo Подписи с квитанций сняты
pause
