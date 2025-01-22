@echo off
set MESSAGE="Начата выгрузка дампа KOMITA_OTKAZ"
cd C:\scripts\!BackUp!\KOMITA\

expdp system/Ghjljdjkmcndbt15980@orakrona parfile=exp_komita_otkaz.ini

