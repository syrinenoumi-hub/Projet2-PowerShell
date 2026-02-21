. "$PSScriptRoot\Get-ProcessInfo.ps1"

$CpuThreshold = Read-Host "Veuillez saisir un seuil CPU (en secondes)"

if (-not ($CpuThreshold -as [int])) {
    Write-Host "Erreur : veuillez entrer un nombre entier." -ForegroundColor Red
    exit
}

$results = Get-HighCPUProcesses -CpuThreshold $CpuThreshold

$results | Format-Table -AutoSize

$choice = Read-Host "`nVoulez-vous exporter les résultats en CSV ? (o/n)"

if ($choice -match '^[Oo]$') {

    # Création d’un dossier "output" dans le même dossier que ton script
    $outputDir = Join-Path $PSScriptRoot "output"

    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    # Génération automatique du nom du fichier
    $timestamp = Get-Date -Format "yyyy-MM-dd"
    $filepath = Join-Path $outputDir "cpu_$timestamp.csv"

    # Tentative d’export CSV
    try {
        $results | Export-Csv -Path $filepath -NoTypeInformation -Encoding UTF8 -Force
        Write-Host "`nFichier exporté avec succès :`n$filepath" -ForegroundColor Green
    }
    catch {
        Write-Error "Erreur lors de l'export CSV : $_"
    }
}
else {
    Write-Host "Exportation annulée."
}
 