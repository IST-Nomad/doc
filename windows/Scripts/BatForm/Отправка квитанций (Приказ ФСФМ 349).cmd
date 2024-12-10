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
Set m_Date=%Date:.=%
Set m_Year=%f_Date:~8,2%

::Директория arhiv_obmen
set dir_arch=l:\arhiv_obmen\КФМ\407P\%f_Year%\%f_Month%\%f_Day%

::Выходная директория АРМ 407 
set dir_find=h:\fsfm_XML\Obmen407p\BANK\FEDSFM

::Директория FS_temp
set dir_temp=c:\FOIV_temp\FSFM_407p\Out\

::Директория отправки
set dir_send=c:\ObmenPTK\OutFS\

::Создаем каталог в arhiv_obmen с текущей датой
md %dir_arch%

echo Перед продолжением приостановите FormSender
pause
echo Продолжаем?
pause

::Ищем каталоги с текущей датой и записываем их в файл
dir %dir_find%\ARHKRFM_042520840_%f_Year%%f_Month%%f_Day%* /b /a:d > c:\BatForm\folders.txt

::Запускаем цикл для каждого найденного каталога
for /f "eol=" %%i in (c:\BatForm\folders.txt) do (
SET FL=%%i

::Копируем все файлы в arhiv_obmen и FS_temp
copy %dir_find%\%%i\*.* %dir_arch%
copy %dir_find%\%%i\*.* %dir_temp%\KVIT_XML\

echo 3. Автоматическая ПОДПИСАНИЕ xml-файлов, ждем 20 сек!!!
timeout 20 /nobreak

::архивируем файлы
arj32.exe a -e %dir_temp%\KVIT_ARJ\%%i.arj %dir_temp%\KVIT_ARJ\

::Удаляем ненужные файлы
del %dir_temp%\KVIT_ARJ\*.xml

echo 3. Автоматическая ПОДПИСАНИЕ arj, ждем 20 сек!!!
timeout 20 /nobreak

::Копируем архив в arhiv_obmen
copy %dir_temp%\%%i.arj %dir_arch%

::Отправляем!
move %dir_temp%\%%i.arj %dir_send%
)
::Конец цикла

echo Проверьте сформированные файлы в папке C:\ObmenPTK\OutFS
echo Если все нормально запускаем FormSender
pause

::Отправляем сообщения в Миранду
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_02@jabber.tcbdomen.trustcombank.ru "Квитанции по 407-п (Приказ ФСФМ 349) отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 fsfm_01@jabber.tcbdomen.trustcombank.ru "Квитанции по 407-п (Приказ ФСФМ 349) отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Квитанции по 407-п (Приказ ФСФМ 349) отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_03@jabber.tcbdomen.trustcombank.ru "Квитанции по 407-п (Приказ ФСФМ 349) отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 oit_02@jabber.tcbdomen.trustcombank.ru "Квитанции по 407-п (Приказ ФСФМ 349) отправлены"

ping localhost -n 3
C:\FormSender\Send2Jabber.exe  ptkpsd@jabber.tcbdomen.trustcombank.ru ptkpsd 10.129.135.253 5222 sib_02@jabber.tcbdomen.trustcombank.ru "Квитанции по 407-п (Приказ ФСФМ 349) отправлены"
