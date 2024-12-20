@echo off
chcp 65001
rem Если папка connections есть, заканчиваем
IF NOT EXIST C:\adm\connections\*.xml GOTO END


:MSG1
TIMEOUT 5
C:\Scripts\Send2Jabber.exe finist_tech@jabber.tcbdomen.trustcombank.ru finist_tech 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Первое сообщение"
GOTO END
:END