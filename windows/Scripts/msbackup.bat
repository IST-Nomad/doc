echo %date% %time% Copy_backup_start >> c:\Backup\copy_backup.txt
robocopy \\FINIST\c$\Backup\Fullbackup \\BKS\FINIST_backup /E /R:3 /W:0
echo %date% %time% Copy_backup_end >> c:\Backup\copy_backup.txt