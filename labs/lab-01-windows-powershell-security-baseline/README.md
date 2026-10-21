# Lab 01 - Windows and PowerShell Security Baseline

**Status:** Prepared, not executed as part of this repository.

## Objective

Learn to collect a minimally invasive Windows security baseline with PowerShell, distinguish observed facts from conclusions and create defensible SOC/SecOps notes.

## Scope and authorization

Owned Windows 10 VirtualBox guest accessed via the host SSH alias `wsi-virtualbox`. All commands are read-only. Obtain approval before agent-initiated command execution. Do not run against production assets without authorization.

## Concepts

- Security context: identity, groups and effective privilege.
- Windows services: running does not imply secure.
- Firewall profiles: profile enabled does not prove every rule is safe.
- Defender status: available protection signals are not a full compromise assessment.
- Network sockets: a listening port is exposure context, not proof of compromise.
- Event Logs: events require timestamps, baselines and context before escalation.

## Procedure

From the host, after reviewing and approving the command:

```powershell
ssh -o BatchMode=yes wsi-virtualbox whoami
```

Run the included script **inside the authorized Windows guest**, after review:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\baseline-readonly.ps1
```

The script prints information to the terminal. It does not change security settings, write files or export raw logs. The `-ExecutionPolicy Bypass` switch applies only to that process; if organizational policy prohibits it, do not use it.

## Evidence checklist

- [ ] Date, host/guest context and authorization recorded privately
- [ ] OS and PowerShell version reviewed
- [ ] Identity and group membership interpreted
- [ ] Firewall profile status checked
- [ ] Defender availability and state checked
- [ ] Selected services checked
- [ ] Listening sockets reviewed with sensitive fields redacted
- [ ] Observations distinguished from inferences
- [ ] Evidence sanitized before publication
- [ ] Remediation or monitoring recommendations justified

## Expected versus observed

**Expected:** read-only terminal output for each available subsystem.

**Observed:** pending execution. No security finding or incident can be concluded yet.

## SOC relevance

Use this baseline to establish context for alert triage, asset review, exposure analysis and least-privilege recommendations. A clean baseline alone does not establish that a machine is uncompromised.
