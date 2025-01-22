@echo off
set MESSAGE="Начата выгрузка дампа RSCONNECT"
cd C:\scripts\!BackUp!\rsconnect\

expdp system/Ghjljdjkmcndbt15980@orakrona parfile=exp_rsconnect.ini


