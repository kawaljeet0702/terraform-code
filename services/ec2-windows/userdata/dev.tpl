<powershell>
Start-Transcript -Append -Path C:\userscriptlog.txt

#Do the Volume stuff and Domain joining
$device_names = "${device_names}".split(",")

$times_waited = 0

"waiting-for-ebs"

#Wait for EBS drives to become avialable
While((Get-Disk).Number.Count -lt ($device_names.Count+1) -and $times_waited -lt 10)
{
  Start-Sleep -s 60
  $times_waited += 1
}

if ($times_waited -gt 9)
{
  "ebs-not-available"
  exit
}

#Resize C: partition to maximum for the mounted drive
$size = (Get-PartitionSupportedSize -DriveLetter C)
Resize-Partition -DriveLetter C -Size $size.SizeMax

#Initialize and format the raw disks
Get-Disk | Where partitionstyle -eq ‘raw’ | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -Confirm:$false
"mounted-drives-updated"

#install python, pip and aws cli
Register-PackageSource -Name Nuget -Location "http://www.nuget.org/api/v2" -ProviderName Nuget -Trusted -Force
Install-Package python
$pythonRootFolder = Join-Path (Split-Path (Get-Package python | % source)) "tools"
$pythonScriptsFolder = Join-Path $pythonRootFolder "Scripts"
$path = [System.Environment]::GetEnvironmentVariable('path', 'Machine')
$path += ";$pythonRootFolder"
$path += ";$pythonScriptsFolder;"
[System.Environment]::SetEnvironmentVariable('path', $path, 'Machine')
$pythonRootFolder = Join-Path (Split-Path (Get-Package python | % source)) "tools"
$pythonScriptsFolder = Join-Path $pythonRootFolder "Scripts"
$path1 = [System.Environment]::GetEnvironmentVariable('path', 'user')
$path1 += ";$pythonRootFolder"
$path1 += ";$pythonScriptsFolder;"
[System.Environment]::SetEnvironmentVariable('path', $path1, 'user')
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
python -m ensurepip
python -m pip install -U pip
pip3 install awscli --upgrade --user
$pythonversion = python -c 'import sys; print(str(sys.version_info[0])+str(sys.version_info[1]))'
$awsfolder = "C:\Users\Administrator\AppData\Roaming\Python\Python$pythonversion\Scripts"
$path2 = [System.Environment]::GetEnvironmentVariable('path', 'user')
$path2 += ";$awsfolder"
[System.Environment]::SetEnvironmentVariable('path', $path2, 'user')
$path3 = [System.Environment]::GetEnvironmentVariable('path', 'Machine')
$path3 += ";$awsfolder"
[System.Environment]::SetEnvironmentVariable('path', $path3, 'Machine')
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
#done installing aws cli

"start-copy-tableau-files-from-s3"
$s3_bucket_for_tableau = "${s3_bucket_for_tableau}"
$destination_folder_name = "${destination_folder_name}"
New-Item -Type Directory D:\$destination_folder_name\ -Force
aws s3 cp $s3_bucket_for_tableau D:\$destination_folder_name\ --recursive --sse aws:kms --sse-kms-key-id mainkey
"tableau-files-copied"

"start-domain-joining"
$environment = "${environment}"
$ad_file_location = "${ad_file_location}"
New-Item -Type Directory 'C:\adduser\' -Force
aws s3 cp $ad_file_location'AES_KEY_FILE_'$environment.key C:\adduser\AES_KEY_FILE_$environment.key --sse aws:kms --sse-kms-key-id mainkey
aws s3 cp $ad_file_location'Get-AutomationUser-'$environment.ps1 C:\adduser\Get-AutomationUser-$environment.ps1 --sse aws:kms --sse-kms-key-id mainkey
Import-Module ServerManager
Add-WindowsFeature RSAT-AD-PowerShell
$server_name = "${server_name}"
$domain = "${domain}"
$wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$adip = Get-ADDomainController -Discover -Domain "$domain"
$wmi.SetDNSServerSearchOrder("$adip.IPv4Address")
Import-Module C:\adduser\Get-AutomationUser-$environment.ps1
$credential = GetHyattDomain
Add-Computer -DomainName $domain -Credential $credential -NewName $server_name -OUPath "OU=Servers,OU=AMZWS,OU=CLOUD,DC=DC,DC=DC,DC=DC" -Force -Verbose
Add-LocalGroupMember -Group "Administrators" -Member ".net\tableausupport","Data.Center.Admins\.net"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member ".net\tableausupport","Data.Center.Admins\.net"
Restart-Computer
"domain-join-completed"

"clean-up-ad-script-file"
Start-Sleep -s 60
Remove-Item -Recurse -Force C:\adduser
"done-with-clean-up"

"Userdata script complete"

Stop-Transcript

</powershell>