# Post Deployment script for Windows SRV 2016
# Autonomic

# Variables
$NewComputerName = "InstanceName"
$ScriptsFolder = "C:\Program Files\Amazon\Ec2ConfigService\Scripts"
$domain = "ansa.aws"

whoami | out-file c:\whoami.txt
$password = cat C:\Windows\securestring.txt | ConvertTo-SecureString -Force
#$password = "plaintextpassword" | ConvertTo-SecureString -asPlainText -Force
$currenthostname = hostname
$username = "$domain\epodev"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

# log output for this script
#$logfile = "C:\Program Files\Amazon\Ec2ConfigService\Logs\post_deployment.log"
$logfile = "C:\ProgramData\Amazon\EC2-Windows\Launch\Log\post_deployment.log"
# |Tee-Object -Append -FilePath $logfile

#join DomainName
# to create the secure password on the Template itself, use Powershell as Administrator and run the following:
# read-host -assecurestring | convertfrom-securestring | out-file C:\Windows\securestring.txt
#Add-Computer -DomainName $domain -Credential $credential -ComputerName $currenthostname -NewName $NewComputerName -Restart
# Join to this OU: ansa.aws/endpoints_ou/Windowssrv2016
Add-Computer -DomainName $domain -Credential $credential -ComputerName $currenthostname -NewName $NewComputerName -OUPath "OU=Windowssrv2016,OU=endpoints_ou,DC=ansa,DC=aws" -Restart |Tee-Object -Append -FilePath $logfile

# try using runas to force running as template user
#runas /noprofile /user:template "powershell.exe c:\test.ps1"
