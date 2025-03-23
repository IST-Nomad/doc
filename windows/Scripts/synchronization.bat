echo off
rem выбираем кодировку для русского языка
chcp 65001
rem копируем 
robocopy F:\book D:\book *.pdf *.epub /E /Z /R:3 /W:1
robocopy F:\Soft D:\Soft /E /Z /R:3 /W:1
robocopy C:\Users\batr\Downloads D:\book *.pdf *.epub /MOVE /E /Z /R:3 /W:1


/COPYALL
robocopy L:\ O:\ /E /COPYALL /MIR /Z /R:3 /W:1