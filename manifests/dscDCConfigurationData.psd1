# Configuration Data for AD  
@{
    AllNodes = @(
        @{
            NodeName="*"
            RetryCount = 20
            RetryIntervalSec = 30
            PSDscAllowPlainTextPassword=$true
            PSDscAllowDomainUser = $true
        },
        @{ 
            Nodename = "dsc-dc"
            Role = "DC"
        }
    )
}