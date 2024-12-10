echo off 
COLOR 2

echo    **************************************************
echo -------------------------------------------------------- 
echo - Отправка 440 формы файлов в автоматическом режиме   --
echo --------------------------------------------------------
echo    **************************************************

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
Set dir_temp_test=C:\FOIV_temp\FNS_440p\Out\Tmp

md %dir_arch%

echo 1. Делаем копию файлов
COPY %dir_in%\BNS*.xml %dir_arch%\
COPY %dir_in%\BOS*.xml %dir_arch%\
COPY %dir_in%\BVS*.xml %dir_arch%\
COPY %dir_in%\BVD*.xml %dir_arch%\
COPY %dir_in%\BNP*.xml %dir_arch%\
COPY %dir_in%\PB*.xml %dir_arch%\

echo 3. Переносим подготовленные файлы в папку для зашифровки
MOVE %dir_in%\BNS*.xml %dir_work%\all\
MOVE %dir_in%\BOS*.xml %dir_work%\all\
MOVE %dir_in%\BVS*.xml %dir_work%\all\
MOVE %dir_in%\BVD*.xml %dir_work%\all\
MOVE %dir_in%\BNP*.xml %dir_work%\all\
MOVE %dir_in%\PB*.xml %dir_work%\PB\

timeout 30 /nobreak

Set f_Date=%Date%
Set f_Year=%f_Date:~6,4%

echo 7.1. Проверка на повторениие номера архива
set Fname=1
:start1
if exist %dir_arch%\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj (
set /a Fname=Fname + 1
goto :start1 )

:repeat
timeout 15 /nobreak
if exist %dir_work%\to_arj\*.* (
echo 7. Подготавливаем архив
arj32.exe a -e %dir_work%\to_arj\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj %dir_work%\to_arj\*.*
goto :next
)
goto :repeat
:next

echo 8. Чистим каталог
DEL %dir_work%\to_arj\*.xml
DEL %dir_work%\to_arj\*.vrb

timeout 15 /nobreak

echo 10. Делаем копию архива
move /y %dir_work%\tmp\AFN_2520840_MIFNS00_%f_Year%%f_Month%%f_Day%_0000%Fname%.arj %dir_arch%

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oper_01@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 ks_02@jabber.tcbdomen.trustcombank.ru " Файлы по 440-п отправлены"
ping localhost -n 3

echo *************************************************
echo ------------------------------------------------- 
echo -        Отправка по 440 форме файлов окончена --
echo -------------------------------------------------
echo ########    Для выхода нажмите [Enter]   ########
echo -------------------------------------------------
echo *************************************************
pause