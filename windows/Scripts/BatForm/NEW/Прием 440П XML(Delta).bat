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


Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,4%

set dir_in=F:\input\foiv-mz\request
set dir_out=H:\no_440\in
rem set dir_work=c:\FOIV_temp\FNS_440p\In
set dir_arch=L:\arhiv_obmen\nalog\440P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%
set dir_arch2=y:\F365\archive\in\%f_Day%%f_Month%%f_Year%


md %dir_arch%
md %dir_arch2%

echo 1. Копируем в archive
COPY %dir_in%\*.arj %dir_arch2%

echo 2. Копируем в arhiv_obmen
COPY %dir_in%\*.xml %dir_arch%

echo 3. Копируем для загрузки в АБС
COPY %dir_in%\RPO*.xml %dir_out%
COPY %dir_in%\ROO*.xml %dir_out%
COPY %dir_in%\PNO*.xml %dir_out%
COPY %dir_in%\PPD*.xml %dir_out%
COPY %dir_in%\PKO*.xml %dir_out%
COPY %dir_in%\APN*.xml %dir_out%
COPY %dir_in%\APO*.xml %dir_out%
COPY %dir_in%\APZ*.xml %dir_out%
COPY %dir_in%\ZSN*.xml %dir_out%
COPY %dir_in%\ZSO*.xml %dir_out%
COPY %dir_in%\ZSV*.xml %dir_out%
COPY %dir_in%\ZSV*.vrb %dir_out%
COPY %dir_in%\TRB*.xml %dir_out%
COPY %dir_in%\TRG*.xml %dir_out%
COPY %dir_in%\KWTFCB*.xml %dir_out%

echo 4. Копируем для печати
::DEL  S:\*.xml
COPY %dir_in%\RPO*.xml S:\
COPY %dir_in%\ROO*.xml S:\
COPY %dir_in%\PNO*.xml S:\
COPY %dir_in%\PPD*.xml S:\
COPY %dir_in%\PKO*.xml S:\
COPY %dir_in%\APN*.xml S:\
COPY %dir_in%\APO*.xml S:\
COPY %dir_in%\APZ*.xml S:\
COPY %dir_in%\ZSN*.xml S:\
COPY %dir_in%\ZSO*.xml S:\
COPY %dir_in%\ZSV*.xml S:\
COPY %dir_in%\ZSV*.vrb S:\
COPY %dir_in%\TRB*.xml S:\
COPY %dir_in%\TRG*.xml S:\

echo 5. Чистим каталог
DEL %dir_in%\*.arj
DEL %dir_in%\*.xml

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oper_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены (Дельта) "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 ks_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены (Дельта) "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 ref_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены (Дельта) "
ping localhost -n 3


C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены (Дельта) "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены (Дельта) "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены (Дельта) "
ping localhost -n 3

pause

