Configuration Baseline {
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node ('localhost') {
        # Disable SMBv1
        Registry DisableSMBv1 {
            Key       = 'HKLM:\\SYSTEM\\CurrentControlSet\\Services\\LanmanServer\\Parameters'
            ValueName = 'SMB1'
            ValueType = 'Dword'
            ValueData = 0
            Ensure    = 'Present'
        }

        # Enforce 14-character minimum password length
        Script PasswordPolicy {
            GetScript  = { @{ Result = (net accounts) } }
            TestScript = { (net accounts) -match 'Minimum password length *: *14' }
            SetScript  = { net accounts /minpwlen:14 }
        }
    }
}

Baseline -OutputPath 'C:\\DSC\\Baseline'
Start-DscConfiguration -Path 'C:\\DSC\\Baseline' -Wait -Force
