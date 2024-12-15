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

set dir_arch=L:\arhiv_obmen\nalog\440P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

Set f_Date=%Date% 
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2% 
Set f_Month=%f_Date:~3,2% 
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,4%

set dir_in=y:\F365\in
set dir_out=H:\no_440\in
set dir_work=c:\FOIV_temp\FNS_440p\In
set dir_arch2=y:\F365\archive\in\%f_Day%%f_Month%%f_Year%


md %dir_arch%
md %dir_arch2%

echo 1. Копируем в archive
COPY %dir_in%\*.arj %dir_arch2%
::pause
echo 2. Переносим подготовленные файлы в папку для расшифровки
MOVE %dir_in%\AFN_MIFNS00_2520840_????????_000??.arj %dir_work%
::pause
DEL %dir_in%\IZVTUB_AFN_2520840_MIFNS00_????????_???.xml

echo 3. Cнимаем подпись c arj через ПТК - Настройка 02 - СКАД Сигнатура!
echo    Нажимаем "Проверка КА" и "Снятие КА"
pause
echo Сняли подпись?
pause

echo 4. Распаковываем файлы
arj32.exe e %dir_work%\AFN_MIFNS00_2520840_????????_000??.arj %dir_work%

echo 5. Удаляем архивы
DEL %dir_work%\AFN_MIFNS00_2520840_????????_000??.arj

echo 6. Меняем раширение
ren %dir_work%\*.vrb *.xml

echo 7. Расшифровываем (с каких получится) и снимаем c xml подпись через ПТК - Настройка 02 - СКАД Сигнатура!
echo    Нажимаем "Расшифрование", "Проверка КА" и "Снятие КА"
pause
echo Расшифровали? Сняли подпись?
pause
echo Деинициализируем ключ!
pause

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
COPY %dir_work%\TRB*.xml %dir_out%
COPY %dir_work%\TRG*.xml %dir_out%
COPY %dir_work%\KWTFCB*.xml %dir_out%

echo 10. Копируем для печати
DEL  S:\*.xml
COPY %dir_work%\RPO*.xml S:\
COPY %dir_work%\ROO*.xml S:\
COPY %dir_work%\PNO*.xml S:\
COPY %dir_work%\PPD*.xml S:\
COPY %dir_work%\PKO*.xml S:\
COPY %dir_work%\APN*.xml S:\
COPY %dir_work%\APO*.xml S:\
COPY %dir_work%\APZ*.xml S:\
COPY %dir_work%\ZSN*.xml S:\
COPY %dir_work%\ZSO*.xml S:\
COPY %dir_work%\ZSV*.xml S:\
COPY %dir_work%\TRB*.xml S:\
COPY %dir_work%\TRG*.xml S:\

echo 11. Чистим каталог
DEL %dir_work%\*.xml

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oper_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 ks_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 ref_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены "
ping localhost -n 3


C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены "
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п загружены "
ping localhost -n 3
pause

