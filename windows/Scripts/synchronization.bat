echo off
rem выбираем кодировку для русского языка
chcp 65001
rem копируем 
robocopy F:\book D:\book *.pdf *.epub /E /Z /R:3 /W:1
robocopy F:\Soft D:\Soft /E /Z /R:3 /W:1
robocopy C:\Users\batr\Downloads D:\book *.pdf *.epub /MOVE /E /Z /R:3 /W:1


rem Копирование со старого диска Т на новый
robocopy \\10.129.135.205\data\Soft "\\qnap246\disk_t\600 - Отдел Информационных Технологий\Soft" /E /R:1 /W:0 

rem Копирование вебинаров со старого диска Q на новый диск Т
robocopy \\qnap247\!r!\!Вебинары! \\qnap246\disk_t\вебинары /E /R:1 /W:0 