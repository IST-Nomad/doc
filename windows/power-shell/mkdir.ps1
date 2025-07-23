# Импортируем модуль Active Directory
Import-Module ActiveDirectory

# Получаем полное имя текущего пользователя из Active Directory
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[1]
$userInfo = Get-ADUser -Identity $currentUser -Properties DisplayName
# Получаем название отдела текущего пользователя из Active Directory
$userdepartment = (Get-ADUser -Identity $currentUser -Properties Department).Department
#путь к лог файлу
$logfile = "\\DC1\netlogon\log\make_start_dir.txt"
# Извлекаем данные из поля "Полное имя"
$fullName = $userInfo.DisplayName
# Формируем имя папки
$folderName = $fullName
# Указываем путь к сетевому ресурсу
$path = "\\SG_1\storage_q\$userdepartment\$folderName"


if ($userDepartment -eq $null) {
    "[$(Get-Date)] У пользователя $currentUser поле 'Отдел' не существует или равно null." | Out-File -FilePath $logfile -Append
} elseif ($userDepartment -eq "") {
	"[$(Get-Date)] У пользователя $currentUser поле 'Отдел' пустое (пустая строка)." | Out-File -FilePath $logfile -Append
} else {
    if (-Not (Test-Path -Path $path)) {
    New-Item -Path $path -ItemType Directory	
	}
}

$acl = Get-Acl -Path $path
	$acl.SetAccessRuleProtection($true, $true)
	Write-Host $path
