@echo off
cd C:\scripts\!BackUp!\Import_FisLog\

impdp system/Ghjljdjkmcndbt15980@krona parfile=FISCLOG_from_dmp.ini
