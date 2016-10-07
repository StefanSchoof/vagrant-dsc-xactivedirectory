Configuration Main
{

  [CmdletBinding()]

  Param (
      [string] $NodeName,
      [string] $domainName
  )
  
$secpasswd = ConvertTo-SecureString "vagrant" -AsPlainText -Force
$domainAdminCredentials = New-Object System.Management.Automation.PSCredential ("vagrant", $secpasswd)

  Import-DscResource -ModuleName PSDesiredStateConfiguration, xActiveDirectory

  Node $AllNodes.Where{$_.Role -eq "DC"}.Nodename
  {
      LocalConfigurationManager
      {
          ConfigurationMode = 'ApplyAndAutoCorrect'
          RebootNodeIfNeeded = $true
      }


      WindowsFeature ADDS_Install
      {
          Ensure = 'Present'
          Name = 'AD-Domain-Services'
      }

      xADDomain CreateForest
      {
          DomainName = $domainName
          DomainAdministratorCredential = $domainAdminCredentials
          SafemodeAdministratorPassword = $domainAdminCredentials
          #DatabasePath = "C:\Windows\NTDS"
          #LogPath = "C:\Windows\NTDS"
          #SysvolPath = "C:\Windows\Sysvol"
          DependsOn = '[WindowsFeature]ADDS_Install'
      }
  }
}
