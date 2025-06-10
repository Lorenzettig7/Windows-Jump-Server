<# 
.SYNOPSIS
  Robocopy-based backup to NAS or external share
#>

$Source = "C:\JumpRepo"
$Dest   = "\\127.0.0.1\JumpBackups"  # Replace with your NAS path or local share
$Log    = "C:\Logs\backup.log"

# Run Robocopy
robocopy $Source $Dest /MIR /R:2 /W:5 /LOG:$Log

# Optional: Timestamp completion
Add-Content -Path $Log -Value "$(Get-Date): Backup complete"
