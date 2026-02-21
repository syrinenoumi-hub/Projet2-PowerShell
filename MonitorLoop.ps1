. "$PSScriptRoot\Get-ProcessInfo.ps1"
$thresholdInput = Read-Host "Seuil CPU (entier)"
$threshold = [int]$thresholdInput

$intervalInput = Read-Host "Intervalle en secondes"
$interval = [int]$intervalInput

while ($true) {
    Clear-Host

    Write-Host "$(Get-Date) - Processus avec CPU > $threshold :" 
    Get-HighCPUProcesses -CpuThreshold $threshold | Format-Table -AutoSize

    Start-Sleep -Seconds $interval
}