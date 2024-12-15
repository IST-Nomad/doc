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

set KVIT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KVIT\%f_Year%\%f_Month%\%f_Day%
set KESDT=L:\TBSVK\RVK_Kontrakt_3_0\B_FTS\406FZ\KESDT\%f_Year%\%f_Month%\%f_Day%

MOVE %KVIT%\KESDT*.arj %KESDT%
TIMEOUT 5
COPY %KESDT%\KESDT*.arj F:\output\foiv-sz\answer
