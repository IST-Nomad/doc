@echo off
set SUBJ="TELEGRAM:INS,BRV"
set MESSAGE="Начата выгрузка дампа KRONA"
cd C:\scripts\!BackUp!\krona_export\

expdp system/Ghjljdjkmcndbt15980@orakrona parfile=exp_krona.ini
