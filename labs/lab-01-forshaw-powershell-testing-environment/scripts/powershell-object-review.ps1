#Requires -Version 5.1
<#
.SYNOPSIS
  Read-only PowerShell object and process review.
.DESCRIPTION
  Displays .NET types and a bounded process inventory. Does not change
  process state, execution policy, or Windows security descriptors.
#>
$ErrorActionPreference = 'Stop'
Write-Host '=== POWERSHELL VERSION ==='
$PSVersionTable.PSVersion
Write-Host "`n=== OBJECT TYPES ==="
[pscustomobject]@{ StringType = ('Windows Security').GetType().FullName; IntegerType = (142).GetType().FullName }
Write-Host "`n=== CURRENT PROCESS ==="
Get-Process -Id $PID | Select-Object ProcessName, Id, Handles
$processes = @(Get-Process)
Write-Host "`n=== TOP 10 BY HANDLE COUNT ==="
$processes | Sort-Object Handles -Descending | Select-Object -First 10 ProcessName, Id, Handles | Format-Table -AutoSize
Write-Host "`n=== TOP 5 BY WORKING SET ==="
$processes | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 ProcessName, Id, WorkingSet64 | Format-Table -AutoSize
Write-Host "`n=== MOST COMMON PROCESS NAMES ==="
$processes | Group-Object ProcessName | Sort-Object Count -Descending | Select-Object -First 5 Count, Name | Format-Table -AutoSize
Write-Host "`n=== HANDLE STATISTICS ==="
$processes | Measure-Object -Property Handles -Average -Maximum -Minimum
