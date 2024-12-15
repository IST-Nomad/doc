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

set katalog=L:\arhiv_obmen\кфм\%f_Year%\%f_Month%\%f_Day%%f_Month%%f_Year%

::Директория arhiv_obmen
set dir_arch=L:\arhiv_obmen\кфм\%f_Year%\%f_Month%\%f_Day%%f_Month%%f_Year%

::Директория импорта
set dir_find=H:\fsfm

::Директория FS_temp
set dir_temp=c:\FS_temp\out\

::Директория отправки на 238 ПТК
set dir_send=\\10.129.135.238\ObmenPTK\OutFS\

::Создаем каталог в arhiv_obmen с текущей датой
md %dir_arch%


::Копируем все файлы в arhiv_obmen и переносим в FS_temp
COPY %dir_find%\SKO4077U_*.xml %dir_arch%
MOVE %dir_find%\SKO4077U_*.xml %dir_temp%

::Имена всех скопрованных файлов записываем в список
dir %dir_temp%\SKO4077U_*.xml /b /s > c:\files_for_sign.txt

::Проставляем КА на все файлы
scsignex.exe -s -ia:\ -ga:\ -oc:\Auto\log_file.txt -lc:\files_for_sign.txt

::Шифруем архив на абонента ФСФМ (номер 0001)
scsignex.exe -e -a0001 -ib:\ -gb:\ -oc:\Auto\log_file.txt -lc:\files_for_sign.txt

Set f_Date=%Date%
Set m_Year=%f_Date:~8,2%
Set f_Year=%f_Date:~6,4%

::Проверка на повторение номера архива
set Fname=1
:start1
if exist %dir_arch%\FM4077U_042520840_%f_Year%%f_Month%%f_Day%_00%Fname%.arj (
set /a Fname=Fname + 1
goto :start1 )

::Подготавливаем архив
arj32.exe a -e C:\FS_TEMP\OUT\FM4077U_042520840_%f_Year%%f_Month%%f_Day%_00%Fname%.arj C:\FS_TEMP\OUT\SKO4077U_*.xml

::Имена архивов записываем в список
dir %dir_temp%\FM4077U_*.arj /b /s > c:\files_for_sign.txt

::Проставляем КА на архив
scsignex.exe -s -ia:\ -ga:\ -oc:\Auto\log_file.txt -lc:\files_for_sign.txt

::Удаляем ненужные файлы
DEL %dir_temp%\SKO4077U_*.xml

::Копируем  Архив
COPY %dir_temp%\FM4077U_042520840_%f_Year%%f_Month%%f_Day%_00%Fname%.arj %dir_arch%

::Отправляем!!!
MOVE %dir_temp%\FM4077U_042520840_%f_Year%%f_Month%%f_Day%_00%Fname%.arj %dir_send%

::Отправляем сообщения в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru "Файлы по 4077-у отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru "Файлы по 4077-у отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Файлы по 4077-у отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Файлы по 4077-у отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 sib_02@jabber.tcbdomen.trustcombank.ru "Файлы по 4077-у отправлены"
