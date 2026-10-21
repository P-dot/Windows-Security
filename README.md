# Windows Security | PowerShell Defensive Labs

Independent, hands-on Windows security learning and SOC/SecOps portfolio by [P-dot](https://github.com/P-dot).

**Scope:** Windows security only (host and authorized Windows 10 VirtualBox guest). This is an educational lab, not a production security assessment. No exploitation or unauthorized activity.

## Primary source and sequence

**James Forshaw, _Windows Security Internals: A Deep Dive into Windows Authentication, Authorization, and Auditing_** is the authoritative source for **chapter order, concepts, commands and worked examples**.

**_Gray Hat Hacking: The Ethical Hacker's Handbook_ (6th edition)** informs only the research methodology: explain the security mechanism, formulate hypotheses, reproduce observations in an authorized VM, assess attacker/defender implications, record evidence, and validate mitigations. It does **not** replace Forshaw's chapter structure.

### Current position

**Part I: An Overview of the Windows Operating System — Chapter 1: Setting Up a PowerShell Testing Environment.** Start at **Choosing a PowerShell Version** and follow the chapter in order: Configuring PowerShell; An Overview of the PowerShell Language (types/variables/expressions; executing commands; command discovery/help; functions; objects; filtering/ordering/grouping; exporting data); Wrapping Up.

**Progress:** Chapter 1 not yet completed or evidenced. The Windows 10 guest SSH connection has been verified, but that does not complete the book's environment setup.

### Documentation rules

- Identify original chapter/section and page before each activity.
- Distinguish **book-directed** actions from **optional gray-hat methodology extensions**.
- Do not attribute invented exercises to Forshaw.
- Do not claim a chapter is complete without performing and recording the relevant exercises.
- Execute only in owned/authorized lab systems; obtain approval for modifications.
- Never publish unsanitized host details, credentials, hashes or raw logs.

**Historical work:** The cross-platform cybersecurity portfolio contains prior Windows baseline and Event Log reviews; they are not chapters completed from Forshaw. See [prior work](docs/PRIOR-WORK.md).

**Existing supplemental draft:** [Windows/PowerShell baseline](labs/lab-01-windows-powershell-security-baseline/README.md) was created before this source correction and is **not** the book's Chapter 1. Do not use it as the canonical sequence.
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

**Next:** Forshaw, Chapter 1, Choosing a PowerShell Version (not yet started). [Supplementary baseline draft](labs/lab-01-windows-powershell-security-baseline/README.md)

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



## Recorded Forshaw lab

- [Lab 01 — PowerShell testing environment](labs/lab-01-forshaw-powershell-testing-environment/README.md): PowerShell 5.1, execution policy, NtObjectManager 2.0.1, security descriptor output. Screenshot manifest included; image files pending import.

