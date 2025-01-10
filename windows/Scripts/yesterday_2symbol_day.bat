echo off 
chcp 65001
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

:: создаем переменную y_Day путем вычитания из текущего дня единицы
set /a y_Day=%f_Day%-1
:: Если переменная y_Day после вычитания получает значение в виде одного символа (что бывает если из 10 отнять 1 получается 9), а нам нужно два символа (например 09) прогоняем цикл
:: И если в переменной меньше двух знаков в начале ставим 0
for /f %%i in ('cmd/v/c "for /l %%i in () do @(if defined d (set d=.!d!) else set d=.)& if defined y_Day (echo.!y_Day!| findstr !d!|| exit/b) else exit/b"^| find/c /v ""') do set "length=%%i"
set yesterday=%length%
if %length% lss 2 goto part2	
:part1
set yesterday=%y_Day%
goto end
:part2
set yesterday=0%y_Day%
:end