# Windows Security | PowerShell Defensive Labs

Independent, hands-on Windows security learning and SOC/SecOps portfolio by [P-dot](https://github.com/P-dot).

**Scope:** Windows security only (host and authorized Windows 10 VirtualBox guest). This is an educational lab, not a production security assessment. No exploitation or unauthorized activity.

## Book-driven roadmap: Gray Hat Hacking, 6th edition (2022)

Primary source: Allen Harper et al., *Gray Hat Hacking: The Ethical Hacker's Handbook*, 6th edition. Independent study notes, not a reproduction of the book.

The source book begins with foundational material (chapters 1-12); this Windows-only repository concentrates on the book's Windows chapters **13-17**, preserving their order and original lab numbering. The full book also includes other platforms and topics outside this repository.

| Source chapter | Exact chapter title | Status |
| --- | --- | --- |
| 13 | Basic Windows Exploitation | Next: Lab 13-1 Compiling on Windows |
| 14 | Windows Kernel Exploitation | Not started |
| 15 | PowerShell Exploitation | Not started |
| 16 | Getting Shells Without Exploits | Not started |
| 17 | Post-Exploitation in Modern Windows Environments | Not started |

**Next book exercise:** Chapter 13, Lab 13-1: Compiling on Windows. First review the chapter's specified tools, example code and prerequisites before installing or running anything. Lab 13-2 (Crashing the Program) follows, then Lab 13-3 (Exploiting ProSSHD Server). Any exploitation must remain in an isolated, authorized lab.

The previous `labs/lab-01-windows-powershell-security-baseline/` is a **supplementary, assistant-created draft**, not a Gray Hat Hacking lab; it remains unexecuted and is not part of the book's sequence. Prior Windows work is documented separately in `docs/PRIOR-WORK.md`.
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

**Next:** Chapter 13, Lab 13-1: Compiling on Windows (not yet started). [Supplementary baseline draft](labs/lab-01-windows-powershell-security-baseline/README.md)

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

