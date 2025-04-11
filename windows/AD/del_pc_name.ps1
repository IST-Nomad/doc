# Указываем дату, которая будет считаться как "год назад"
$oneYearAgo = (Get-Date).AddYears(-1)

# Получаем все компьютеры из Active Directory
$computers = Get-ADComputer -Filter * -Property LastLogonDate

# Перебираем каждый компьютер
foreach ($computer in $computers) {
    # Проверяем дату последней авторизации
    if ($computer.LastLogonDate -lt $oneYearAgo) {
        # Выводим информацию о компьютере, который будет удален
        Write-Host "Удаляем компьютер: $($computer.Name), Последняя авторизация: $($computer.LastLogonDate)"

        # Удаляем компьютер из Active Directory
        #Сначала проверить всё ли работает, затем, для удаления строчку ниже раскоментировать
        #Remove-ADComputer -Identity $computer -Confirm:$false
    }
}