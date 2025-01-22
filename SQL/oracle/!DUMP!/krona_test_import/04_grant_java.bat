@echo off
set SUBJ="TELEGRAM:INS,BRV"
sqlplus sys/Cthdth2003@test19 as sysdba @java_tst.sql

rem sqlplus sys/Ghjljdjkmcndbt15980@krona as sysdba @java.sql

rem set MESSAGE="Отработал последний батник по вгрузке дампа. Схема KRONA_TST готова к работе."
rem call C:\scripts\diff\EmailTelegrSend\EmailTelegrSend.cmd