$Source = "C:\JumpRepo"
$Dest   = "\\127.0.0.1\JumpBackups"
$Log    = "C:\Logs\backup.log"

# Ensure log folder exists
if (!(Test-Path "C:\Logs")) { New-Item "C:\Logs" -ItemType Directory }

# Start log
"Backup started at $(Get-Date)" | Out-File $Log

# Robocopy all files including empty dirs
robocopy $Source $Dest /E /R:2 /W:5 /LOG+:$Log

# Report status
if ($LASTEXITCODE -le 7) {
    "SUCCESS: Files copied at $(Get-Date)" | Out-File -Append $Log
} else {
    "FAILURE: Robocopy exit code $LASTEXITCODE at $(Get-Date)" | Out-File -Append $Log
}
