# Script to Create Windows 10 instances from our custom ami

# Declare Instance Variables
# ImageID template last update using: Win10
$ImageId = "ami-0fea2a7fc377c48e8"
$KeyName = "autonomic-official-id_rsa"
$InstanceType = "t2.small"
$SubnetId = "subnet-0f6c04d7b5e8b1946"
$SecurityGroupId = "sg-0afbf649fe41843b7"
$InstanceName = Read-Host -Prompt 'Input the name of the instance:'
$Tags = @( @{key="Name";value="$InstanceName"},
           @{key="AutoOff";value="True"},
           @{key="owner";value="steve"} )
$UserDataTemplate = 'C:\autonomic_workarea\autonomic-software_producteng\AWS\powershell\deployment_scripts\post_deployment-win10.ps1'
$UserDataTempFile = Join-Path $env:temp '\post_deployment.ps1'
#Make instanceName entry in post_deployment Script
(Get-Content $UserDataTemplate).replace('InstanceName', $InstanceName) | Set-Content $UserDataTempFile

#UserData:
# change the following line to point to the same directory as your: Unfuddle checkout folder: autonomic-software_producteng\AWS\powershell\deployment_scripts
$userDataString = Get-Content -Path $UserDataTempFile | Out-String
$userDataString = @"
<powershell>
$userDataString
</powershell>
"@

$EncodeUserData = [System.Text.Encoding]::UTF8.GetBytes($userDataString)
$userData = [System.Convert]::ToBase64String($EncodeUserData)

# example command line:
#New-EC2Instance -ImageId "ami-022dd5efa12655ec9" -KeyName "autonomic-official-id_rsa" -InstanceType "t2.small" -SubnetId "subnet-0f6c04d7b5e8b1946" -SecurityGroupId "sg-0afbf649fe41843b7"-TagSpecification $tagspec1
#Launch instance (without TagSpecification)
$NewInstanceResponse = New-EC2Instance -ImageId "$ImageId" -KeyName "$KeyName" -InstanceType "$InstanceType" -SubnetId "$SubnetId" -UserData $userData

#Retrieve Instance id(s)
$Instances = ($NewInstanceResponse.Instances).InstanceId

#Apply tags to instances
New-EC2Tag -ResourceId $Instances -Tags $Tags

Write-Host "Finished deploying instance: $InstanceName"
