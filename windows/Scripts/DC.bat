@echo off
rem Если папка connections есть, заканчиваем
IF EXIST C:\adm\connections GOTO END
:INSTALL1
rem копируем содержимое папки connections 
robocopy \\10.129.135.200\netlogon\Finist\connections C:\adm\connections /E /R:1 /W:0 
rem Если папка icon есть, заканчиваем
IF EXIST C:\adm\icon GOTO END
:INSTALL2
rem копируем содержимое папки icon
robocopy \\10.129.135.200\netlogon\Finist\icon C:\adm\icon /E /R:1 /W:0
:END