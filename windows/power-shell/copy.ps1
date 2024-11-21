# Указываем необходимые переменные
$sourceFile = "C:\Distr\тестовый_файлик.txt"  # Путь к исходному файлу, который нужно скопировать
$destinationPath = "C$\adm"  # Путь, по которому файл будет скопирован на каждом компьютере

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
        Write-Host "Ошибка при копировании на $computer"
    }
}



# Указываем необходимые переменные
$sourceFile = "C:\path\to\your\file.txt"  # Путь к исходному файлу
$destinationPath = "C$\path\to\destination"  # Путь назначения на удалённых компьютерах

# Получаем список всех компьютеров в домене
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Перебираем каждый компьютер
foreach ($computer in $computers) {
    try {
        # Формируем полный путь к папке назначения
        $destination = "\\$computer\$destinationPath"

        # Проверяем доступность компьютера
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
            # Копируем файл
            Copy-Item -Path $sourceFile -Destination $destination -Force -ErrorAction Stop
            Write-Host "Файл успешно скопирован на $computer в $destination"
        } else {
            Write-Host "Компьютер $computer недоступен"
        }
    } catch {
        Write-Host "Ошибка при копировании на $computer: $_"
    }
}



# Указываем необходимые переменные
$sourceFile = "C:\path\to\your\file.txt"  # Путь к исходному файлу
$destinationPath = "C$\path\to\destination"  # Путь назначения на удалённых компьютерах
$unreachableComputersFile = "C:\path\to\unreachable_computers.txt"  # Путь к файлу для записи недоступных компьютеров

# Убедимся, что файл для недоступных компьютеров существует, если нет - создадим его
if (-Not (Test-Path $unreachableComputersFile)) {
    New-Item -Path $unreachableComputersFile -ItemType File -Force
}

# Получаем список всех компьютеров в домене
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Перебираем каждый компьютер
foreach ($computer in $computers) {
    try {
        # Формируем полный путь к папке назначения
        $destination = "\\$computer\$destinationPath"

        # Проверяем доступность компьютера
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
            # Копируем файл
            Copy-Item -Path $sourceFile -Destination $destination -Force -ErrorAction Stop
            Write-Host "Файл успешно скопирован на $computer в $destination"
        } else {
            Write-Host "Компьютер $computer недоступен"
            # Записываем недоступный компьютер в файл
            Add-Content -Path $unreachableComputersFile -Value $computer
        }
    } catch {
        Write-Host "Ошибка при копировании на $computer: $_"
        # Записываем недоступный компьютер в файл
        Add-Content -Path $unreachableComputersFile -Value $computer
    }
}

Write-Host "Список недоступных компьютеров записан в $unreachableComputersFile"



# Указываем переменные
$computersFile = "C:\path\to\your\computers.txt"  # Путь к текстовому файлу с именами компьютеров
$sourceFile = "C:\path\to\your\file.txt"  # Путь к исходному файлу, который нужно скопировать
$destinationPath = "C$\path\to\destination"  # Путь назначения на удалённых компьютерах
$unreachableComputersFile = "C:\path\to\unreachable_computers.txt"  # Путь к файлу для записи недоступных компьютеров

# Убедимся, что файл для недоступных компьютеров существует, если нет - создадим его
if (-Not (Test-Path $unreachableComputersFile)) {
    New-Item -Path $unreachableComputersFile -ItemType File -Force
}

# Читаем список компьютеров из файла
$computers = Get-Content -Path $computersFile

# Перебираем каждый компьютер
foreach ($computer in $computers) {
    try {
        # Формируем полный путь к папке назначения
        $destination = "\\$computer\$destinationPath"

        # Проверяем доступность компьютера
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
            # Копируем файл
            Copy-Item -Path $sourceFile -Destination $destination -Force -ErrorAction Stop
            Write-Host "Файл успешно скопирован на $computer в $destination"
        } else {
            Write-Host "Компьютер $computer недоступен"
            # Записываем недоступный компьютер в файл
            Add-Content -Path $unreachableComputersFile -Value $computer
        }
    } catch {
        Write-Host "Ошибка при копировании на $computer: $_"
        # Записываем недоступный компьютер в файл
        Add-Content -Path $unreachableComputersFile -Value $computer
    }
}

Write-Host "Список недоступных компьютеров записан в $unreachableComputersFile"



# Указываем переменные
$computersFile = "C:\path\to\your\computers.txt"  # Путь к текстовому файлу с именами компьютеров
$sourceFile = "C:\path\to\your\file.txt"  # Путь к исходному файлу, который нужно скопировать
$destinationPath = "C$\path\to\destination"  # Путь назначения на удалённых компьютерах

# Читаем список компьютеров из файла
$computers = Get-Content -Path $computersFile

# Перебираем каждый компьютер
foreach ($computer in $computers) {
    try {
        # Формируем полный путь к папке назначения
        $destination = "\\$computer\$destinationPath"

        # Проверяем доступность компьютера
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
            # Копируем файл
            Copy-Item -Path $sourceFile -Destination $destination -Force -ErrorAction Stop
            Write-Host "Файл успешно скопирован на $computer в $destination"

            # Удаляем компьютер из списка
            $computers = $computers | Where-Object { $_ -ne $computer }
        } else {
            Write-Host "Компьютер $computer недоступен"
        }
    } catch {
        Write-Host "Ошибка при копировании на $computer: $_"
    }
}

# Записываем обновлённый список компьютеров обратно в файл
$computers | Set-Content -Path $computersFile

Write-Host "Обновлённый список компьютеров записан в $computersFile"



# Установка пути к файлу, куда будет записан список компьютеров
$outputFile = "C:\Scripts\computers_list.txt"  # Укажите свой путь

# Получаем список всех компьютеров в домене
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Записываем список в файл
$computers | Set-Content -Path $outputFile

Write-Host "Список всех компьютеров в домене записан в файл $outputFile"


