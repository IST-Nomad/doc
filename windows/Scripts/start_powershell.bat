
:: всегда явно указывай политику исполнения при запуске из планировщика
powershell.exe -ExecutionPolicy Bypass -File "C:\Scripts\Backup.ps1"

:: если нужно логирование — добавь вывод в файл
powershell.exe -ExecutionPolicy Bypass -File "C:\Scripts\Backup.ps1" >> C:\Logs\backup.log 2>&1
