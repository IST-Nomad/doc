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
set dir_work=c:\FOIV_temp\FNS_440p\In
set dir_arch=L:\arhiv_obmen\nalog\440P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%
set dir_arch2=y:\F365\archive\in\%f_Day%%f_Month%%f_Year%


md %dir_arch%
md %dir_arch2%

echo 1. Копируем в archive
COPY %dir_in%\*.arj %dir_arch2%

::pause
echo 2. Переносим подготовленные файлы в папку для расшифровки
MOVE %dir_in%\AFN_MIFNS00_2520840_????????_000??.arj %dir_work%
::pause

timeout 20 /nobreak
echo 4. Распаковываем файлы
arj32.exe e %dir_work%\arj\AFN_MIFNS00_2520840_????????_000??.arj %dir_work%\work

timeout 30 /nobreak

echo 8. Копируем в arhiv_obmen
COPY %dir_work%\*.xml %dir_arch%
echo 9. Копируем для загрузки в АБС
COPY %dir_work%\RPO*.xml %dir_out%
COPY %dir_work%\ROO*.xml %dir_out%
COPY %dir_work%\PNO*.xml %dir_out%
COPY %dir_work%\PPD*.xml %dir_out%
COPY %dir_work%\PKO*.xml %dir_out%
COPY %dir_work%\APN*.xml %dir_out%
COPY %dir_work%\APO*.xml %dir_out%
COPY %dir_work%\APZ*.xml %dir_out%
COPY %dir_work%\ZSN*.xml %dir_out%
COPY %dir_work%\ZSO*.xml %dir_out%
COPY %dir_work%\ZSV*.xml %dir_out%
COPY %dir_work%\ZSV*.vrb %dir_out%
COPY %dir_work%\TRB*.xml %dir_out%
COPY %dir_work%\TRG*.xml %dir_out%
COPY %dir_work%\KWTFCB*.xml %dir_out%

echo 10. Копируем для печати
::DEL  S:\*.xml
COPY %dir_work%\backup\RPO*.xml S:\
COPY %dir_work%\backup\ROO*.xml S:\
COPY %dir_work%\backup\PNO*.xml S:\
COPY %dir_work%\backup\PPD*.xml S:\
COPY %dir_work%\backup\PKO*.xml S:\
COPY %dir_work%\backup\APN*.xml S:\
COPY %dir_work%\backup\APO*.xml S:\
COPY %dir_work%\backup\APZ*.xml S:\
COPY %dir_work%\backup\ZSN*.xml S:\
COPY %dir_work%\backup\ZSO*.xml S:\
COPY %dir_work%\backup\ZSV*.xml S:\
COPY %dir_work%\backup\ZSV*.vrb S:\
COPY %dir_work%\backup\TRB*.xml S:\
COPY %dir_work%\backup\TRG*.xml S:\

copy %dir_work%\*.xml %dir_arch%\
echo 11. Чистим каталог
DEL %dir_work%\backup\*.*.
DEL %dir_work%\arj\*.arj
DEL %dir_work%\*.xml

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

