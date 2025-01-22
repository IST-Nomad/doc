@echo off
set SUBJ="TELEGRAM:INS,BRV"
set MESSAGE="Начата выгрузка дампа KRONA_TST"
cd C:\scripts\!BackUp!\krona_test_export\

expdp system/Cthdth2003@test19 parfile=exp_krona_tst.ini
