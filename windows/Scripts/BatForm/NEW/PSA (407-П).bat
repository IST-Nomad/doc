Setlocal EnableDelayedExpansion

echo off 
COLOR 2

::Переменные из даты для работы
Set f_Date=%Date%
Set f_Time=%Time%
Set f_Day=%f_Date:~0,2%
Set f_Month=%f_Date:~3,2%
Set f_Year=%f_Date:~6,4%
Set f_Month=%f_Month: =%
Set f_Day=%f_Day: =%

::Выходная директория АРМ 407
set dir_find=h:\fsfm_XML\Obmen407p\BANK\FEDSFM

::Директория arhiv_obmen - куда кладутся файлы и формируются архивы на отправку
set dir_arch=l:\arhiv_obmen\КФМ\407P\%f_Year%\%f_Month%\%f_Day%

::Директория отправки Дельты
set dir_send=f:\output\foiv-fz\answer

::Создаем каталог в arhiv_obmen с текущей датой
md %dir_arch%

SET folders_patname=DIFM_042520840_%f_Year%%f_Month%%f_Day%*
SET arch_patname=%folders_patname%.a*
SET folderstxt=c:\BatForm\folders.txt

::Ищем каталоги с текущей датой и записываем их имена в файл
dir %dir_find%\%folders_patname% /b /a:d > %folderstxt%

::Запускаем цикл для каждого найденного каталога
for /f "eol=" %%i in (%folderstxt%) do (
SET FL=%%i

md %dir_arch%\!FL!

::Копируем все файлы в arhiv_obmen
copy %dir_find%\!FL!\*.* %dir_arch%\!FL!

::Архивируем файлы (возможен многотомный архив по 5 МБ)
Arj32.exe A -V5000k -Y -E %dir_arch%\!FL!.arj %dir_arch%\!FL!\
)

::Копируем в папку отправки Дельты
copy %dir_arch%\%arch_patname% %dir_send%

::очистка всех файлов, в т.ч. во вложенных каталогах
del /f /s /q %dir_arch%\*.*
::удаление этих каталогов (только если они пусты)
for /f "eol=" %%i in (%folderstxt%) do ( 
SET FL=%%i
rd /q %dir_arch%\!FL! 
)

::Отправляем сообщения в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru "Файлы по 407-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru "Файлы по 407-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Файлы по 407-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Файлы по 407-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 sib_02@jabber.tcbdomen.trustcombank.ru "Файлы по 407-п отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Файлы по 407-п отправлены"

pause