# Указываем необходимые переменные
$sourceFile = "C:\path\to\your\file.txt"  # Путь к исходному файлу, который нужно скопировать
$destinationPath = "C$\path\to\destination"  # Путь, по которому файл будет скопирован на каждом компьютере

# Получаем список всех компьютеров в домене
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Перебираем каждый компьютер
foreach ($computer in $computers) {
    try {
        # Формируем полный путь назначения
        $destination = "\\$computer\$destinationPath"

        # Проверяем, доступен ли компьютер
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
            # Копируем файл
            Copy-Item -Path $sourceFile -Destination $destination -Force
            Write-Host "Файл скопирован на $computer в $destination"
        } else {
            Write-Host "Компьютер $computer недоступен"
        }
    } catch {
        Write-Host "Ошибка при копировании на $computer: $_"
    }
}