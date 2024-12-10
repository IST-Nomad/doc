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

::set dir_in=H:\no_XML\out
::set dir_out=c:\ObmenPTK\OutFS
set dir_work=c:\_test\311p\out\
::set dir_arch=L:\arhiv_obmen\nalog\fz311xml\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

set xml_files=SFC*0?????_7**.xml

::md %dir_arch%

::echo 1. Делаем копию файлов
::COPY %dir_in%\%xml_files% %dir_arch%

::echo 3. Переносим подготовленные файлы в папку для зашифровки
::MOVE %dir_in%\%xml_files% %dir_work%

"C:\Program Files\MDPREI\spki\spki1utl.exe" -profile 07-FOIV -sign -data c:\_test\311p\out\SFC012520840_380820191223_249900001900000612_700.xml -out c:\_test\311p\out\SFC012520840_380820191223_249900001900000614_700.xml
"C:\Program Files\MDPREI\spki\spki1utl.exe" -profile 07-FOIV -sign -data c:\_test\311p\out\SFC012520840_380820191223_249900001900000613_700.xml -out c:\_test\311p\out\SFC012520840_380820191223_249900001900000615_700.xml

pause