echo off 
COLOR 2

echo    **************************************************
echo -------------------------------------------------------- 
echo - Отправка 311 файлов ФИЗ ЛИЦ в автоматическом режиме --
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

set dir_in=Z:\311\gb\out\0
set dir_out=F:\output\foiv-2z\answer
set dir_arch=L:\arhiv_obmen\nalog\fz311xml\%f_Year%\%f_Month%\%f_Day%%f_Month%%m_Year%

set xml_files=SFC*0?????_7**.xml

md %dir_arch%

echo 1. Делаем копию файлов
COPY %dir_in%\%xml_files% %dir_arch%

Set f_Date=%Date%
Set m_Year=%f_Date:~8,2%

echo 2. Проверка на повторение номера архива
set Fname=1
:start1
if exist %dir_arch%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj (
set /a Fname=Fname + 1
goto :start1 )

timeout 20 /nobreak
:repeat
if exist %dir_in%\%xml_files% (
echo 3. Подготавливаем архив
arj32.exe a -e %dir_in%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj %dir_in%\%xml_files%
goto :next
)
timeout 5 /nobreak
goto :repeat

:next

echo 4. Удаляем xml-файлы
DEL %dir_in%\%xml_files%

echo 5. Копируем  Архив
COPY %dir_in%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj %dir_arch%

echo 6. Отправляем!!!
MOVE %dir_in%\BN20840%m_Year%%f_Month%%f_Day%000%Fname%.arj %dir_out%

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Файлы по 311-п (ФИЗИКИ) отправлены (Дельта,Finist)"
timeout 2 /nobreak

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Файлы по 311-п (ФИЗИКИ) отправлены (Дельта,Finist)"
timeout 2 /nobreak

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Файлы по 311-п (ФИЗИКИ) отправлены (Дельта,Finist)"
timeout 2 /nobreak

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 gdr_02@jabber.tcbdomen.trustcombank.ru "Файлы по 311-п (ФИЗИКИ) отправлены (Дельта,Finist)"
timeout 2 /nobreak

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fiz_03@jabber.tcbdomen.trustcombank.ru "Файлы по 311-п (ФИЗИКИ) отправлены (Дельта,Finist)"
timeout 2 /nobreak

C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fiz_02@jabber.tcbdomen.trustcombank.ru "Файлы по 311-п (ФИЗИКИ) отправлены (Дельта,Finist)"

echo *************************************************
echo ------------------------------------------------- 
echo -        Отправка 311 файлов окончена          --
echo -------------------------------------------------
echo ########    Для выхода нажмите [Enter]   ########
echo -------------------------------------------------
echo *************************************************
pause