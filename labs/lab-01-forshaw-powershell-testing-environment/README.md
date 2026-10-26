# Lab 01 - PowerShell Testing Environment

**Reference:** James Forshaw, *Windows Security Internals*, Chapter 1: Setting Up a PowerShell Testing Environment.

**Environment:** Windows 10 virtual machine, Windows PowerShell 5.1, Oracle VirtualBox.

**Status:** Environment validated and PowerShell object-processing exercises completed. Remaining Chapter 1 material is in progress.

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

## 5. PowerShell types and expressions

The Windows PowerShell 5.1 session confirmed the .NET types `System.Int32`, `System.String`, `System.Boolean` and `System.Double`. The arithmetic, string, bitwise and array expressions below returned the expected results:

| Expression | Observed result |
| --- | --- |
| `1 + 2` | `3` |
| `"Hello" + "World!"` | `HelloWorld!` |
| `0x1FF -band 0xFF` | `255` |
| `0x100 -bor 0x20` | `288` |
| `0xCC -bxor 0xDD` | `17` |
| `$var = 3,2,1,0; $var[1]` | `2` |

Binary conversion verified `0xCC XOR 0xDD = 0x11` (`00010001` in eight-bit notation). Double-quoted strings expanded variables; single-quoted strings preserved literal dollar signs. Backtick escaping was checked using newlines, tabs, embedded quotation marks and escaped variable references.

## 6. .NET object inspection

String properties and methods were inspected with `Get-Member` and tested using `Length`, `ToUpper()`, `ToLower()`, `Contains()` and `Substring()`. A `System.DateTime` object was constructed and formatted.

`New-NtSecurityDescriptor` returned an `NtCoreLib.Security.Authorization.SecurityDescriptor` instance. The following properties were observed:

| Property | Value |
| --- | --- |
| `Owner`, `Group` | Not specified |
| `DaclPresent` | `False` |
| `DaclNull` | `False` |
| `DaclAceCount` | `0` |
| `SaclPresent` | `False` |
| `SaclAceCount` | `0` |
| `IntegrityLevel` | `Medium` |

The descriptor remained in memory. No access-control list was applied to a resource and no access check was performed. An absent DACL, a null DACL and a present but empty DACL must not be treated as equivalent.

## 7. Command discovery and functions

`Get-Command *Process*` identified native PowerShell commands and NtObjectManager functions. `Get-Process` was confirmed as a cmdlet from `Microsoft.PowerShell.Management`. Local `Get-Help` returned basic syntax and the aliases `gps` and `ps`, but the extended help files were not installed.

`Get-Process -Id $PID` returned a `System.Diagnostics.Process` object. The invocation operator `&` executed a command name stored in a variable. A parameterless function returned a string; a typed `Get-ProcessSummary -ProcessId $PID` function returned selected process properties. Command discovery identified the latter as `Function` with parameter `ProcessId`.

## 8. Read-only process inventory

A single process snapshot (`$procesos = Get-Process`) was examined with `Where-Object`, `Sort-Object`, `Group-Object`, `Select-Object` and `Measure-Object`. The initial filter produced an extensive output; a bounded second run improved readability.

### Observations — 26 October 2026

| Measurement | Observed value |
| --- | --- |
| Process objects | **141** |
| Mean handle count | **374.63829787234** |
| Maximum handle count | **2,956** — `System`, PID 4 |
| Minimum handle count | **0** |
| Largest group | **73** instances of `svchost` |
| Second-largest group | **12** instances of `msedgewebview2` |

Top five working sets:

| Process | PID | Working set (bytes) |
| --- | ---: | ---: |
| `MsMpEng` | 2216 | 263,954,432 |
| `SearchApp` | 7124 | 178,745,344 |
| `msedgewebview2` | 7060 | 153,534,464 |
| `explorer` | 5884 | 104,222,720 |
| `msedgewebview2` | 2708 | 100,450,304 |

The snapshot is time-dependent and limited to processes visible to the current user. Handle count and memory use alone do not establish malicious activity. This was an inventory exercise, not an incident investigation or an authorization test.

### Reproduction

The [read-only PowerShell script](scripts/powershell-object-review.ps1) reproduces the bounded object and process queries. It does not alter security descriptors, stop processes, install packages or change execution policy.

## Assessment

The tested PowerShell language constructs, object queries and process pipelines produced the expected results. This establishes a functioning exploratory environment, not a security assessment of the Windows guest. Further Chapter 1 work will be documented only after execution.

## Evidence index

[View all screenshots and verification output](evidence/README.md).
