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

set dir_in=y:\fz550p\in
set dir_out=h:\fsfm_XML\Obmen550p\CBRF\BANK\
set dir_work=c:\FOIV_temp\FSFM_550p\In
set dir_arch=L:\arhiv_obmen\КФМ\550P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

md %dir_arch%

echo 1. Переносим подготовленные файлы в папку для расшифровки

COPY %dir_in%\cb_550p*.arj %dir_work%\backup\
MOVE %dir_in%\cb_550p*.arj %dir_work%

echo 2. Распаковываем файлы
arj32.exe e %dir_work%\cb_550p*.arj %dir_work%

echo 3. Удаляем архивы
DEL %dir_work%\cb_550p*.arj

echo 4. Расшифровываем и снимаем подпись через ПТК - Настройка 03 - СКАД Сигнатура!
echo    Нажимаем "Расшифрование", "Проверка КА" и "Снятие КА"
pause

echo 7. Копируем в arhiv_obmen
COPY %dir_work%\backup\CB_ES550P*.xml %dir_arch%


echo 9. Чистим каталог...
pause
DEL %dir_work%\backup\*.xml

echo 10. Отправляем сообщения в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_06@jabber.tcbdomen.trustcombank.ru "Файлы по 550-п загружены"
pause