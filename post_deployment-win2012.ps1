# Post Deployment script for Windows SRV 2012R2
# This script gets injected to VM instance via AWS userdata during provisioning
# Autonomic

# Variables
$NewComputerName = "InstanceName"
$ScriptsFolder = "C:\Program Files\Amazon\Ec2ConfigService\Scripts"
$domain = "ansa.aws"
$password = cat C:\Windows\securestring.txt | ConvertTo-SecureString -Force
#$password = "plaintextpassword" | ConvertTo-SecureString -asPlainText -Force
$currenthostname = hostname
$username = "$domain\epodev"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

# log output for this script
$logfile = "C:\Program Files\Amazon\Ec2ConfigService\Logs\post_deployment.log"
# |Tee-Object -Append -FilePath $logfile

#join DomainName
Add-Computer -DomainName $domain -Credential $credential -ComputerName $currenthostname -NewName $NewComputerName -OUPath "OU=Windowssrv2012,OU=endpoints_ou,DC=ansa,DC=aws" -Restart |Tee-Object -Append -FilePath $logfile
