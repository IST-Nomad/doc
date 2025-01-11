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

set dir_arh1=y:\407p\ArhAns\%f_Year%\%f_Month%
set dir_arh2=L:\arhiv_obmen\КФМ\407P\%f_Year%\%f_Month%\%f_Day%

md %dir_arh1%
md %dir_arh2%

echo 1. Копируем в archive
COPY y:\407p\in\RFM_042520840*.zip %dir_arh1%

echo 2. Переносим файлы архивов в папку для расшифровки
MOVE y:\407p\in\RFM_042520840*.zip c:\FOIV_temp\FSFM_407p\In\RFM_ARJ\

echo 3. Автоматическая РАСШИФРОВКА архивов, ждем 20 сек!!!
timeout 20 /nobreak

pause

echo 4. Распаковываем zip-архивы
"c:\Program Files\7-Zip\7z.exe" x c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.zip -oc:\FOIV_temp\FSFM_407p\In\

pause

echo 5. Удаляем архивы
DEL c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.zip

echo 6. Копируем в arhiv_obmen
COPY c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.xml %dir_arh2%
COPY c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.sign %dir_arh2%

echo 7. Копируем для загрузки в АРМ 407п
COPY c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.xml h:\fsfm_XML\Obmen407p\FEDSFM\BANK\

echo 8. Чистим каталог
DEL c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.xml
DEL c:\FOIV_temp\FSFM_407p\In\RFM_042520840*.sign

echo 9. Отправляем сообщение в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru " Файлы по 407-п загружены "
::pause
ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru " Файлы по 407-п загружены "

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru " Файлы по 407-п загружены "

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 sib_02@jabber.tcbdomen.trustcombank.ru " Файлы по 407-п загружены "
::pause
ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru " Файлы по 407-п загружены "
::pause
ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru " Файлы по 407-п загружены "

pause
