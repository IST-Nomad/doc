# Импортируем модуль Active Directory
Import-Module ActiveDirectory
# Получаем логин пользователя
$username = $env:USERNAME

# Получаем информацию о пользователе из Active Directory
$user = Get-ADUser -Identity $username -Properties GivenName, Surname, Initials

# Формируем полное имя (Фамилия Имя Отчество)
$fullName = "$($user.Surname) $($user.GivenName) $($user.Initials)".Trim()

# Путь к сетевой папке (с поддержкой кириллицы)
$networkPath = "\\10.129.135.103\storage_l\$fullName"

# Проверяем, существует ли папка
if (-not (Test-Path -Path $networkPath)) {
    # Создаем папку
    New-Item -Path $networkPath -ItemType Directory
    Add-NTFSAccess -Path $networkPath -Account 'TCBDOMEN\$username' -AccessRights 'Fullcontrol' -PassThru
}
if (Test-PAth -Path $networkPath) {
    Add-NTFSAccess -Path $networkPath -Account 'TCBDOMEN\$username' -AccessRights 'Fullcontrol' -PassThru
}