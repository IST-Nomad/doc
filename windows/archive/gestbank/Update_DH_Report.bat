@echo off
rem Таймауты проставил на всякий случай
color 2
rem Выключаем новые подключения
change logon /disable
rem Убиваем процесс связанный с приложением для копированияrem Отключаем всех пользователей кроме тех что указаны в скрипте (админы)
powershell -file C:\Scripts\killproc_DH_Report.ps1
rem Удаляем папки со всем содержимым
RMDIR \\GESTBANK\c$\Finist\DH_Report /S /Q 
rem Копируем с боевого сервера в тестовые папки всё кроме конфигов
robocopy \\FINIST-TRANS\c$\Finist\DH_Report \\GESTBANK\c$\Finist\DH_Report\ /E /R:1 /W:0 
rem Включаем новые подключения
change logon /enable