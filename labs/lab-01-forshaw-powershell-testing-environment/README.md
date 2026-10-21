# Lab 01 — Setting Up a PowerShell Testing Environment

**Primary source:** James Forshaw, *Windows Security Internals: A Deep Dive into Windows Authentication, Authorization, and Auditing*, Part I, Chapter 1.

**Methodology:** Follow Forshaw's order and examples. Use *Gray Hat Hacking* only as an investigative methodology: hypothesis, controlled experiment, evidence, interpretation and defensive implications. Network troubleshooting is supplemental, **not** an exercise attributed to Forshaw.

**Status:** Environment setup and the first NtObjectManager security descriptor example verified from user screenshots. Chapter 1 language sections pending.

## 1. Choosing a PowerShell Version

```powershell
$PSVersionTable
Get-Command pwsh -ErrorAction SilentlyContinue
```

Observed: Windows PowerShell **5.1.19041.3803**, edition **Desktop**, build **10.0.19041.3803**, CLR **4.0.30319.42000**. No `pwsh` command found in this session (not proof of absence elsewhere).

## 2. Configuring PowerShell

```powershell
Get-ExecutionPolicy -List
Get-ExecutionPolicy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
Get-ExecutionPolicy
Get-ExecutionPolicy -List
```

**Before:** all scopes `Undefined`, effective `Restricted`. **After user approval:** effective `RemoteSigned`; `CurrentUser = RemoteSigned`, other scopes `Undefined`.

**Gray Hat analysis:** Execution policy is not a security boundary. `RemoteSigned` permits local unsigned scripts, with signature requirements for scripts marked as downloaded from the Internet. The change affects the current user, not the whole machine. Possible rollback (only with explicit approval): `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Undefined`.

## 3. NuGet failure and network diagnosis — supplemental environment work

```powershell
Get-Module -ListAvailable NtObjectManager
Install-Module NtObjectManager -Scope CurrentUser -Force
Test-NetConnection www.powershellgallery.com -Port 443
Test-NetConnection go.microsoft.com -Port 443
[Net.ServicePointManager]::SecurityProtocol
```

Initial module installation failed while downloading the NuGet provider. Both Microsoft domain names failed DNS resolution. TLS displayed `SystemDefault`, which does not establish a TLS fault.

The guest had an internal `LabSeguridad` adapter with APIPA addressing, a host-only adapter that supported SSH, and no IPv4 default route. With user approval, Windows was shut down normally and a **third NAT adapter** added, retaining the existing two. After reboot the NAT adapter obtained an address and default gateway. `Test-NetConnection www.powershellgallery.com -Port 443` returned **`TcpTestSucceeded : True`**.

**Interpretation:** local SSH connectivity does not imply Internet access. The missing default route explains the inability to reach package repositories. This troubleshooting is not a Forshaw exercise.

## 4. NtObjectManager installation and descriptor example

```powershell
Install-Module NtObjectManager -Scope CurrentUser -Force
Get-Module -ListAvailable NtObjectManager
Import-Module NtObjectManager
Get-Module NtObjectManager
New-NtSecurityDescriptor
```

The user accepted the NuGet provider installation. **NtObjectManager 2.0.1** installed and imported successfully. The first descriptor example returned:

```text
Owner  DACL ACE Count  SACL ACE Count  Integrity Level
-----  --------------  --------------  ---------------
NONE   NONE            NONE            NONE
```

**Gray Hat analysis:** This creates a security descriptor in memory; it does not change the ACL of any Windows object. No allow/deny decision was tested. An absent DACL is not equivalent to an empty DACL.

## Results and next step

**Verified:** PowerShell version, execution policy before/after, restored Internet connectivity, module installation/import, descriptor output. **Not yet done:** Chapter 1 sections on types, variables, expressions, command execution, help, functions, objects, filtering and exporting. No compromise or vulnerability is claimed.

**Next in Forshaw's order:** *Understanding Types, Variables, and Expressions*, following the book's own examples.

## Evidence

See [evidence manifest](evidence/README.md). The user provided screenshots in chat. These images are **not yet uploaded** to this repository; they require transfer and privacy review before publication.
