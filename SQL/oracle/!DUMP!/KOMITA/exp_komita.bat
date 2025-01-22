@echo off
set MESSAGE="Начата выгрузка дампа KOMITA"
cd C:\scripts\!BackUp!\KOMITA\

expdp system/Ghjljdjkmcndbt15980@krona parfile=exp_komita.ini

