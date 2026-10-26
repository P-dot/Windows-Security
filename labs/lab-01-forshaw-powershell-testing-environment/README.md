# Lab 01 - PowerShell Testing Environment

**Reference:** James Forshaw, *Windows Security Internals*, Chapter 1: Setting Up a PowerShell Testing Environment.

**Environment:** Windows 10 virtual machine, Windows PowerShell 5.1, Oracle VirtualBox.

**Status:** PowerShell testing environment configured and validated.

## Objective

Prepare a repeatable PowerShell environment for examining Windows security internals, verify the NtObjectManager module, and inspect the output of a newly created security descriptor.

## 1. PowerShell version

```powershell
$PSVersionTable
Get-Command pwsh -ErrorAction SilentlyContinue
```

The installed Windows PowerShell version was **5.1.19041.3803** (Desktop edition). The `pwsh` command was not available through command discovery in the tested session.

Evidence: [01](evidence/01-powershell-version.jpg).

## 2. Execution policy

```powershell
Get-ExecutionPolicy -List
Get-ExecutionPolicy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
Get-ExecutionPolicy -List
```

Initially, all execution policy scopes were `Undefined`, with an effective policy of `Restricted`. After setting the current-user policy, the effective policy was `RemoteSigned`; the other scopes remained `Undefined`.

Execution policy helps control script execution but is not a security boundary. The change was limited to `CurrentUser` rather than `LocalMachine`.

Evidence: [02](evidence/02-execution-policy-initial.jpg), [03](evidence/03-execution-policy-effective.jpg), [04](evidence/04-execution-policy-verified.jpg).

## 3. Package installation and connectivity

```powershell
Get-Module -ListAvailable NtObjectManager
Install-Module NtObjectManager -Scope CurrentUser -Force
Test-NetConnection www.powershellgallery.com -Port 443
```

The initial installation attempt failed while downloading the NuGet provider. DNS resolution was unavailable because the guest had no Internet route. Its internal and host-only adapters provided lab connectivity but no default gateway for external access.

A third VirtualBox adapter using NAT was added while preserving the existing lab adapters. Following restart, DNS and TCP connectivity to the PowerShell Gallery endpoint on port 443 succeeded.

The connectivity issue was an environment dependency encountered during setup, not a finding about Windows access controls.

Evidence: [05](evidence/05-nuget-install-error.jpg), [06](evidence/06-dns-failure.jpg), [07](evidence/07-nat-https-restored.jpg).

## 4. NtObjectManager verification

```powershell
Install-Module NtObjectManager -Scope CurrentUser -Force
Get-Module -ListAvailable NtObjectManager
Import-Module NtObjectManager
Get-Module NtObjectManager
New-NtSecurityDescriptor
```

NtObjectManager **2.0.1** was installed successfully and imported into the session. The security descriptor command produced the following output:

```text
Owner  DACL ACE Count  SACL ACE Count  Integrity Level
-----  --------------  --------------  ---------------
NONE   NONE            NONE            NONE
```

The command created an unconfigured security descriptor in memory. It did not apply permissions to a Windows object or execute an access check. In Windows security, an absent DACL and an empty DACL have different implications and must not be treated as equivalent.

Evidence: [08](evidence/08-ntobjectmanager-installed.jpg), [09](evidence/09-security-descriptor.jpg).

## Results

- Windows PowerShell 5.1 identified.
- Execution policy configured at current-user scope.
- External package connectivity restored.
- NtObjectManager 2.0.1 installed and imported.
- Initial security descriptor output reproduced.

A separate [read-only verification record](evidence/10-live-verification.txt) confirms the current environment state.

## Evidence index

[View all screenshots and verification output](evidence/README.md).
