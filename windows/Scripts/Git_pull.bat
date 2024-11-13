@echo off

Set f_Date=%Date%
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2%
Set f_Month=%f_Date:~3,2%
Set f_Year=%f_Date:~6,4%
Set f_Hour=%Time:~0,5%

Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%

cd C:\Users\oit_10\Documents\Doc
git pull origin work
