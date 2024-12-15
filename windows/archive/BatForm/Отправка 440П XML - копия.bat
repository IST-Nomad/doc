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

set dir_in=H:\no_440\out
set dir_out=c:\ObmenPTK\OutFS
set dir_work=c:\FOIV_temp\FNS_440p\Out
set dir_arch=L:\arhiv_obmen\nalog\440P\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

md %dir_arch%

echo 1. Делаем копию файлов
COPY %dir_in%\BNS*.xml %dir_arch%
COPY %dir_in%\BOS*.xml %dir_arch%
COPY %dir_in%\BVS*.xml %dir_arch%
COPY %dir_in%\BVD*.xml %dir_arch%
COPY %dir_in%\BNP*.xml %dir_arch%
COPY %dir_in%\PB*.xml %dir_arch%

echo 3. Переносим подготовленные файлы в папку для зашифровки
MOVE %dir_in%\BNS*.xml %dir_work%\
MOVE %dir_in%\BOS*.xml %dir_work%\
MOVE %dir_in%\BVS*.xml %dir_work%\
MOVE %dir_in%\BVD*.xml %dir_work%\
MOVE %dir_in%\BNP*.xml %dir_work%\
MOVE %dir_in%\PB*.xml %dir_work%\

echo 4. Подписываем xml через ПТК - Настройка 02 - СКАД Сигнатура!
echo    Нажимаем "Постановка КА"
pause
echo Подписали?
pause

echo 3. Переносим квитанции PB во временный каталог
MOVE %dir_work%\PB*.xml %dir_work%\Tmp

echo 5. Шифруем xml через ПТК - Настройка 02 - СКАД Сигнатура!
echo    Нажимаем "Шифрование"
pause
echo Зашифровали?
pause

echo 5. Меняем раширение
ren %dir_work%\BNS*.xml *.vrb
ren %dir_work%\BOS*.xml *.vrb
ren %dir_work%\BVS*.xml *.vrb
ren %dir_work%\BVD*.xml *.vrb
ren %dir_work%\BNP*.xml *.vrb

echo 6. Переносим обратно квитанции PB из временного каталога
MOVE %dir_work%\Tmp\PB*.xml %dir_work%

Set f_Date=%Date%
Set f_Year=%f_Date:~6,4%

echo 7.1. Проверка на повторениие номера архива
set Fname=1
:start1
if exist %dir_arch%\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj (
set /a Fname=Fname + 1
goto :start1 )

echo 7. Подготавливаем архив
arj32.exe a -e %dir_work%\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj %dir_work%\*.*

echo 8. Чистим каталог
DEL %dir_work%\*.xml
DEL %dir_work%\*.vrb

echo 4. Подписываем архив arj через ПТК - Настройка 02 - СКАД Сигнатура!
echo    Нажимаем "Постановка КА"
pause
echo Подписали?
pause
echo Деинициализируем ключ!
pause

echo 10. Делаем копию архива
COPY /-Y %dir_work%\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj %dir_arch%

echo 11. Отправляем!!!
MOVE %dir_work%\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj %dir_out%

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oper_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 ks_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3
pause