# Read-only baseline. Review before running on an authorized Windows guest.
$ErrorActionPreference = 'Continue'
Write-Output '=== OS ==='
Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber
Write-Output '=== PowerShell ==='
$PSVersionTable.PSVersion.ToString()
Write-Output '=== Identity ==='
whoami
Write-Output '=== Groups (review privately; do not publish raw output) ==='
whoami /groups
Write-Output '=== Firewall profiles ==='
Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
Write-Output '=== Defender status (if available) ==='
if (Get-Command Get-MpComputerStatus -ErrorAction SilentlyContinue) {
  Get-MpComputerStatus | Select-Object AMServiceEnabled, AntivirusEnabled, RealTimeProtectionEnabled
} else { Write-Output 'Get-MpComputerStatus unavailable' }
Write-Output '=== Selected services ==='
Get-Service -Name EventLog, WinDefend, MpsSvc, sshd -ErrorAction SilentlyContinue | Select-Object Name, Status, StartType
Write-Output '=== Listening TCP sockets (sensitive; do not publish raw output) ==='
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Select-Object LocalAddress, LocalPort, OwningProcess
