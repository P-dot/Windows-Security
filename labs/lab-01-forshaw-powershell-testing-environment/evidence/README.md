# Lab 01 - Evidence

Screenshots captured during the Windows 10 PowerShell environment setup. Network adapter details have been excluded from image 07. Images have been re-encoded without original image metadata.

| Evidence | Description |
| --- | --- |
| [01 - PowerShell version](01-powershell-version.jpg) | Installed PowerShell version and edition |
| [02 - Initial execution policy](02-execution-policy-initial.jpg) | Execution policy scope values before configuration |
| [03 - Execution policy change](03-execution-policy-effective.jpg) | Effective policy and change confirmation |
| [04 - Verified execution policy](04-execution-policy-verified.jpg) | CurrentUser RemoteSigned |
| [05 - NuGet installation failure](05-nuget-install-error.jpg) | Initial dependency download error |
| [06 - DNS troubleshooting](06-dns-failure.jpg) | Name resolution failure |
| [07 - Connectivity restored](07-nat-https-restored.jpg) | HTTPS connectivity after NAT configuration |
| [08 - Module installation](08-ntobjectmanager-installed.jpg) | NtObjectManager 2.0.1 available |
| [09 - Security descriptor](09-security-descriptor.jpg) | Imported module and security descriptor output |
| [10 - Read-only verification](10-live-verification.txt) | Subsequent independent command output |

## Process inventory — 26 October 2026

The process-inventory results are recorded in the [Lab 01 report](../README.md#8-read-only-process-inventory). The final screenshots were supplied during the session; the reported values have been transcribed into the report. The [reproduction script](../scripts/powershell-object-review.ps1) provides a repeatable read-only collection procedure. New runs will have different PIDs and resource counts.
