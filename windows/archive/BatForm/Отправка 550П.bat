echo off 
COLOR 2
echo ------------------------------------------------- 
echo - Отправка 550П файлов в автоматическом режиме --
echo -------------------------------------------------
Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,2%

rem Для отправки за вчерашний день [a.ershov 29.05.2020]
rem Set /a "f_Day=%f_Day: =%-1"

set name_arh = ARH550P_2499_0000_%f_Year%%f_Month%%f_Day%_001.arj
set katalog_obmen=h:\fsfm_XML\Obmen550p\BANK\CBRF
set katalog_arhiv=L:\arhiv_obmen\КФМ\550P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

md %katalog_arhiv%

Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,2%

rem Для отправки за вчерашний день [a.ershov 29.05.2020]
rem Set /a "f_Day=%f_Day: =%-1"

echo 1. Копируем подготовленный архив в папку для подписания
copy %katalog_obmen%\ARH550P_2499_0000_%f_Year%%f_Month%%f_Day%_001.arj C:\FOIV_temp\FSFM_550p\OUT\


echo 3. Делаем копию архива
:repeat
timeout 10 /nobreak
if exist C:\FOIV_temp\FSFM_550p\Out\tmp\ARH550P_2499_0000_%f_Year%%f_Month%%f_Day%_001.arj (
MOVE /y C:\FOIV_temp\FSFM_550p\Out\tmp\ARH550P_2499_0000_%f_Year%%f_Month%%f_Day%_001.arj %katalog_arhiv%
goto :next
)
goto :repeat
:next

echo 5. Отправляем сообщения в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п отправлены"

echo ------------------------------------------------- 
echo - Отправка 550П файлов окончена                --
echo -------------------------------------------------
echo ########    Для выхода нажмите [Enter]   ########
echo -------------------------------------------------
pause