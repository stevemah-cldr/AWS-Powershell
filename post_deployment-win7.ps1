# Post Deployment script for Windows 7
# Autonomic
# Requires Windows 7 Template with Powershell 3.0 or higher

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

# install chocolatey package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# add to the path for this session
$ENV:PATH = "$ENV:PATH;C:\ProgramData\chocolatey\bin;"
#Start-Sleep -s 20

# install Mozilla Firefox
C:\ProgramData\chocolatey\bin\choco install firefox -y |Tee-Object -Append -FilePath $logfile
#C:\ProgramData\chocolatey\bin\choco install putty -y |Tee-Object -Append -FilePath $logfile

#join DomainName
# to create the secure password on the Template itself, use Powershell as Administrator and run the following:
# read-host -assecurestring | convertfrom-securestring | out-file C:\Windows\securestring.txt
#Add-Computer -DomainName $domain -Credential $credential -ComputerName $currenthostname -NewName $NewComputerName -Restart
# Join to this OU: ansa.aws/endpoints_ou/Windows7
Add-Computer -DomainName $domain -Credential $credential -ComputerName $currenthostname -NewName $NewComputerName -OUPath "OU=Windows7,OU=endpoints_ou,DC=ansa,DC=aws" -Restart |Tee-Object -Append -FilePath $logfile
