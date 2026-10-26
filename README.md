# Windows Security Internals | Practical Labs

Practical Windows security research focused on authentication, authorization, access control, and system internals.

This repository documents reproducible experiments conducted in an isolated Windows 10 virtual machine. The work is based on James Forshaw's *Windows Security Internals: A Deep Dive into Windows Authentication, Authorization, and Auditing*.

## Labs

| Lab | Topic | Status |
| --- | --- | --- |
| [01 - PowerShell Testing Environment](labs/lab-01-forshaw-powershell-testing-environment/README.md) | PowerShell configuration, NuGet, NtObjectManager and initial descriptor | Completed |
| [02 - PowerShell Objects and Process Analysis](labs/lab-02-powershell-object-and-process-analysis/README.md) | Types, expressions, objects, functions, pipelines and process inventory | Documented; image import pending |

## Lab environment

- Windows 10 virtual machine on Oracle VirtualBox
- Windows PowerShell 5.1
- NtObjectManager PowerShell module
- Isolated lab networking with temporary NAT access for package installation

## Documentation

Each lab records the objective, commands, observed results, technical interpretation, and supporting evidence. Screenshots are included where they help establish a result. Commands are performed on systems under the operator's control.

The repository distinguishes observed results from assumptions. Sensitive host details and credentials are excluded from published evidence.

## Previous Windows security work

Related Windows baseline and event log analysis are maintained separately in the [cybersecurity portfolio](https://github.com/P-dot/cybersecurity-portfolio).

## Reference

James Forshaw, *Windows Security Internals: A Deep Dive into Windows Authentication, Authorization, and Auditing*, No Starch Press.
