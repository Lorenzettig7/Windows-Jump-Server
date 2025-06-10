<# 
.SYNOPSIS
  Audits local admin group and enforces UAC setting
#>

# Enumerate local admins
$admins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name

# Enforce: only expected accounts allowed (adjust for your actual admin accounts)
$expected = @("WIN-TON0I0785K9\Administrator")

$unexpected = $admins | Where-Object { $_ -notin $expected }

if ($unexpected) {
    Add-Content -Path "C:\Logs\PrivAudit.log" -Value "$(Get-Date): WARNING – Unexpected admin accounts: $($unexpected -join ', ')"
} else {
    Add-Content -Path "C:\Logs\PrivAudit.log" -Value "$(Get-Date): Admin group OK"
}

# Enforce UAC prompt = Always Notify
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name ConsentPromptBehaviorAdmin -Value 2
