function Get-HighCPUProcesses {
    param (
        [int]$CpuThreshold
    )

    $process = Get-Process | Where-Object { $_.CPU -ge $CpuThreshold }

    $processinfo = $process | Select-Object Name, Id, `
        @{ Name = "MemoryMB"; Expression = { "{0:N2}" -f ($_.WorkingSet64 / 1MB) } }, `
        CPU

    $sortprocess = $processinfo | Sort-Object MemoryMB -Descending

    return $sortprocess
}
