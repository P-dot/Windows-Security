# Lab 02 - PowerShell Objects and Process Analysis

**Date:** 26 October 2026  
**Environment:** Windows 10 VM, Windows PowerShell 5.1, NtObjectManager 2.0.1  
**Scope:** PowerShell object handling, security descriptor inspection and read-only process inventory.

## Objective

Validate PowerShell's object-oriented pipeline and use it to inspect a security descriptor and collect a bounded process inventory. The exercises were performed on an authorized Windows lab VM. They are supplementary practice, not claimed as verbatim book exercises.

## 1. PowerShell types and expressions

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

## 2. .NET object inspection

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

## 3. Command discovery and functions

`Get-Command *Process*` identified native PowerShell commands and NtObjectManager functions. `Get-Process` was confirmed as a cmdlet from `Microsoft.PowerShell.Management`. Local `Get-Help` returned basic syntax and the aliases `gps` and `ps`, but the extended help files were not installed.

`Get-Process -Id $PID` returned a `System.Diagnostics.Process` object. The invocation operator `&` executed a command name stored in a variable. A parameterless function returned a string; a typed `Get-ProcessSummary -ProcessId $PID` function returned selected process properties. Command discovery identified the latter as `Function` with parameter `ProcessId`.

## 4. Read-only process inventory

A single process snapshot (`$procesos = Get-Process`) was examined with `Where-Object`, `Sort-Object`, `Group-Object`, `Select-Object` and `Measure-Object`. The initial filter produced an extensive output; a bounded second run improved readability.

### Observations â€” 26 October 2026

| Measurement | Observed value |
| --- | --- |
| Process objects | **141** |
| Mean handle count | **374.63829787234** |
| Maximum handle count | **2,956** â€” `System`, PID 4 |
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


## Evidence

[Evidence index](evidence/README.md). Screenshots from the interactive session are pending import; observations have been recorded in the tables above.
