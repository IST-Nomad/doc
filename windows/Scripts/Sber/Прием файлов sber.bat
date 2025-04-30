@echo off 
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

set katalog=l:\in\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%
md %katalog%
echo.
echo Копируем файл в Архив:
COPY C:\ABS\SBRF.ABS.CM.UFEBS.F\*.* %katalog%

echo.  
echo Переносим файл в папку SBER на Mailbox:
move C:\ABS\SBRF.ABS.CM.UFEBS.F\*.* H:\in\

echo.   
echo Список принятых файлов в Mailbox\in:
echo ---------------------------
dir h:\in\*.* /B
echo ---------------------------
echo.
echo Готово!
pause