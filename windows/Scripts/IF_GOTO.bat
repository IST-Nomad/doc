@echo off
chcp 65001
rem Если файлов с расширением xml нет по пути то идем к MSG2 Если есть то идем ниже по скрипту
IF NOT EXIST C:\adm\connections\*.xml GOTO MSG2
:MSG1
TIMEOUT 5
C:\Scripts\Send2Jabber.exe finist_tech@jabber.tcbdomen.trustcombank.ru finist_tech 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Файлы есть"
GOTO END
:MSG2
TIMEOUT 5
C:\Scripts\Send2Jabber.exe finist_tech@jabber.tcbdomen.trustcombank.ru finist_tech 10.129.135.253 5222 oit_01@jabber.tcbdomen.trustcombank.ru "Нет файлов"
:END