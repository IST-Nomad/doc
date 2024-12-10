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

set dir_in=F:\input\foiv-wz\request
set dir_out=h:\fsfm_XML\Obmen550p\CBRF\BANK\
rem set dir_work=c:\FOIV_temp\FSFM_550p\In
set dir_arch=L:\arhiv_obmen\КФМ\550P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

md %dir_arch%

echo 1. Переносим подготовленные файлы в папку для расшифровки

DEL %dir_work%\cb_550p*.arj
COPY %dir_in%\CB_ES550P*.xml %dir_arch%
MOVE %dir_in%\CB_ES550P*.xml %dir_out%


echo 2. Отправляем сообщения в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены (Дельта)"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены (Дельта)"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены (Дельта)"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены (Дельта)"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_06@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены (Дельта)"
ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены (Дельта)"

pause
