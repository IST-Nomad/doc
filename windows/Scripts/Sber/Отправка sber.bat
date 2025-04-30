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

set katalog1=l:\out\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

md %katalog1%


echo Копируем файл в Архив
COPY H:\out\*.* %katalog1%

echo Переносим и отправляем файл в SBER
move H:\out\*.* C:\ABS\ABS.SBRF.CM.UFEBS.F\


pause