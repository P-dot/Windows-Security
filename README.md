# Windows Security | PowerShell Defensive Labs

Independent, hands-on Windows security learning and SOC/SecOps portfolio by [P-dot](https://github.com/P-dot).

**Scope:** Windows security only (host and authorized Windows 10 VirtualBox guest). This is an educational lab, not a production security assessment. No exploitation or unauthorized activity.

## Learning roadmap

| Lab | Topic | Status |
| --- | --- | --- |
| 01 | Windows and PowerShell security baseline | Ready to execute; no evidence collected here yet |
| 02 | Local users, groups, UAC and effective privileges | Planned |
| 03 | NTFS permissions, ACLs and least privilege | Planned |
| 04 | Services, processes and persistence review | Planned |
| 05 | Windows Event Logs and PowerShell logging | Planned |
| 06 | Microsoft Defender and Windows Firewall | Planned |
| 07 | TCP/IP, listening ports, SMB, WinRM and SSH | Planned |
| 08 | Windows hardening and configuration drift | Planned |
| 09 | SOC triage and incident response fundamentals | Planned |
| 10 | Capstone: documented Windows security assessment | Planned |

## Lab methodology

Each lab documents objectives, scope, relevant concepts, exact commands, expected versus observed results, sanitized evidence, defensive interpretation, remediation, and lessons learned. An unexecuted lab is never labeled completed.

## Verified environment and limitations

- Host: Windows workstation, PowerShell, Git and VS Code.
- Guest: authorized Windows 10 VirtualBox VM reachable through the configured SSH alias `wsi-virtualbox`.
- SSH authentication was successfully tested from the host using `ssh -o BatchMode=yes wsi-virtualbox whoami`, returning exit code 0.
- Guest configuration may differ from host. Read-only assessment is the default. Any changes require explicit approval.
- Avoid publishing IP addresses, user names, host names, credentials, private keys, raw sensitive logs or personally identifying evidence.

## Existing work: not duplicated

The separate [cybersecurity-portfolio](https://github.com/P-dot/cybersecurity-portfolio) already contains:
- [Lab 03: Windows Security Baseline](https://github.com/P-dot/cybersecurity-portfolio/tree/main/03-windows-security-baseline): identity, privileges, networking, services, firewall, Defender, events, and PID/port correlation.
- [Lab 07: Windows Event Log Defensive Review](https://github.com/P-dot/cybersecurity-portfolio/tree/main/07-windows-event-log-defensive-review): sanitized event inventory, authentication review and SOC triage. Its recorded conclusion was no confirmed compromise, P3 review/monitor.

Those are previous independent lab results, **not** newly executed Windows-Security labs. See [prior work and boundaries](docs/PRIOR-WORK.md).

## Start here

[Lab 01: Windows and PowerShell security baseline](labs/lab-01-windows-powershell-security-baseline/README.md)

## Repository layout

```text
Windows-Security/
  README.md
  .gitignore
  docs/
    PRIOR-WORK.md
  labs/
    lab-01-windows-powershell-security-baseline/
      README.md
      scripts/
        baseline-readonly.ps1
      evidence/
        README.md
```

## Security and publishing policy

Use only owned or explicitly authorized systems. Never commit credentials, secrets, unsanitized exports, personal data or production artifacts. Store raw findings outside this public repository and publish only reviewed, sanitized evidence.
