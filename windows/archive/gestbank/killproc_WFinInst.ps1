$processName = "WFinist"
# Get a list of processes with the specified name
$processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
# If processes are found, kill them
if ($processes) {
Write-Host "Killing $processName processes..."
$processes | Stop-Process -Force
Write-Host "Processes killed successfully."
} else {
Write-Host "No $processName processes found."
}