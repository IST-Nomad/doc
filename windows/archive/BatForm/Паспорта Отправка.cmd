echo off 
COLOR 2

set dir_in=H:\fts
set dir_out=F:\output\foiv-tz\answer

echo 1. Перемещаем файл из MailBox в каталог на отправку
MOVE %dir_in%\*.a* %dir_out%
pause