# Used to install 3rd party applications on Windows endpoints for testing or for template creation
# set-ExecutionPolicy = unrestricted to use this script on the command line
# The goal of this script is to not have the latest version of Software install since we will need to package them
# chocolatey is primarily used for the install process because we want an older version
# however there are some packages that only installs the latest version, ie: Google Chrome, and Flash flashplayer
# we can use our own GUR MSI packages to install older versions of that Software

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# https://chocolatey.org/packages/GoogleChrome/66.0.3359.13900 - 4/24/2018
#choco install googlechrome --version 66.0.3359.13900 -y
choco install googlechrome -y

# Install GoogleChrome from GUR
# either use gur.autonomic-software.com or 172.16.1.25 depending if your on AWS or internally at Autonomic
#Invoke-WebRequest -OutFile googlechrome_standalone_enterprise_64_6603359170.msi http://172.16.1.25/GUR/googlechrome_standalone_enterprise_64_6603359170.msi
#Invoke-WebRequest -OutFile $env:temp\googlechrome_standalone_enterprise_64_6603359170.msi http://gur.autonomic-software.com/GUR/googlechrome_standalone_enterprise_64_6603359170.msi
#$installfile = "$env:temp\googlechrome_standalone_enterprise_64_6603359170.msi"
#start-Process msiexec.exe -Wait -ArgumentList '$env:temp''\googlechrome_standalone_enterprise_64_6603359170.msi /qn'

# https://chocolatey.org/packages/Firefox/58.0 - 1/23/2018
choco install firefox --version 58.0 -y

# install older versions of 3rd party software

# https://chocolatey.org/packages/adobereader/2015.007.20033.01 - 3/15/2017
choco install adobereader --version 2015.007.20033.01 -y

# https://chocolatey.org/packages/flashplayerppapi/28.0.0.137 - 1/9/2018
#choco install flashplayerppapi --version 28.0.0.137 -y
# https://chocolatey.org/packages/flashplayerppapi/28.0.0.161 - 2/6/2018
#choco install flashplayerppapi --version 28.0.0.161 -y
choco install flashplayerppapi -y

# https://chocolatey.org/packages/flashplayeractivex/28.0.0.137 - 1/9/2018
choco install flashplayeractivex --version 28.0.0.137 -y

# https://chocolatey.org/packages/javaruntime/7.0.75 - 1/27/2015
#choco install javaruntime --version 7.0.75 -y

# https://chocolatey.org/packages/javaruntime/8.0.144 - 8/11/2017
choco install javaruntime --version 8.0.144 -y
