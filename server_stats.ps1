
# Server Performance Stats
# Collects system information and saves a report automatically.

$ErrorActionPreference = "Stop"

# Create a timestamp for the report
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

# Save reports inside a reports folder
$reportFolder = Join-Path $PSScriptRoot "reports"

if (!(Test-Path $reportFolder)) {
    New-Item -Path $reportFolder -ItemType Directory -Force |
        Out-Null
}

$reportFile = Join-Path $reportFolder "performance_$timestamp.txt"

# Start collecting report lines
$report = @()

$report += "===== SERVER PERFORMANCE STATS ====="
$report += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$report += ""

# CPU usage
$cpu = Get-CimInstance Win32_Processor |
    Measure-Object -Property LoadPercentage -Average

$cpuUsage = [math]::Round($cpu.Average, 2)

$report += "CPU Usage: $cpuUsage%"
# CPU usage alert
if ($cpuUsage -ge 80) {
    $cpuAlert = "WARNING: High CPU usage detected!"
    Write-Host $cpuAlert -ForegroundColor Red
    $report += $cpuAlert
}
else {
    $report += "CPU Status: Normal"
}
$report += ""

# Memory usage
$os = Get-CimInstance Win32_OperatingSystem

$totalRAM = [math]::Round(
    $os.TotalVisibleMemorySize / 1MB, 2
)

$freeRAM = [math]::Round(
    $os.FreePhysicalMemory / 1MB, 2
)

$usedRAM = [math]::Round(
    $totalRAM - $freeRAM, 2
)

$report += "Total RAM: $totalRAM GB"
$report += "Used RAM: $usedRAM GB"
$report += "Free RAM: $freeRAM GB"
# RAM usage alert
$ramUsagePercent = [math]::Round(
    (($usedRAM / $totalRAM) * 100), 2
)

if ($ramUsagePercent -ge 80) {
    $ramAlert = "WARNING: High RAM usage detected! ($ramUsagePercent%)"
    Write-Host $ramAlert -ForegroundColor Red
    $report += $ramAlert
}
else {
    $report += "RAM Status: Normal ($ramUsagePercent% used)"
}
$report += ""

# Disk usage
$disks = Get-CimInstance Win32_LogicalDisk `
    -Filter "DriveType=3"

foreach ($disk in $disks) {
    $total = [math]::Round($disk.Size / 1GB, 2)
    $free = [math]::Round($disk.FreeSpace / 1GB, 2)
    $used = [math]::Round($total - $free, 2)

    $report += "Drive: $($disk.DeviceID)"
    $report += "Total Space: $total GB"
    $report += "Used Space: $used GB"
    $report += "Free Space: $free GB"
    $report += ""
}

$report += "===== REPORT COMPLETED ====="

# Display report in PowerShell
$report | ForEach-Object { Write-Host $_ }

# Save report to a text file
$report | Set-Content -Path $reportFile -Encoding UTF8

Write-Host ""
Write-Host "Report saved successfully!" -ForegroundColor Green
Write-Host "File location: $reportFile" -ForegroundColor Cyan
