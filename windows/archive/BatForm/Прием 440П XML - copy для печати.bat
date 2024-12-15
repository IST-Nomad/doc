::echo off 
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


Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,4%

set dir_arch=L:\arhiv_obmen\nalog\440P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

echo 10. Копируем для печати
COPY %dir_arch%\RPO*.xml S:\!\
COPY %dir_arch%\ROO*.xml S:\!\
COPY %dir_arch%\PNO*.xml S:\!\
COPY %dir_arch%\PPD*.xml S:\!\
COPY %dir_arch%\PKO*.xml S:\!\
COPY %dir_arch%\APN*.xml S:\!\
COPY %dir_arch%\APO*.xml S:\!\
COPY %dir_arch%\APZ*.xml S:\!\
COPY %dir_arch%\ZSN*.xml S:\!\
COPY %dir_arch%\ZSO*.xml S:\!\
COPY %dir_arch%\ZSV*.xml S:\!\
COPY %dir_arch%\ZSV*.vrb S:\!\
COPY %dir_arch%\TRB*.xml S:\!\
COPY %dir_arch%\TRG*.xml S:\!\

pause

