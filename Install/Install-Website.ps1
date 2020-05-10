#Add required types
Add-Type -AssemblyName System.IO.Compression.FileSystem

#Set TLS Defaults
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Install IIS
Install-WindowsFeature -name 'Web-Server','Web-WebSockets' -IncludeManagementTools

#Install PowerShell Modules
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module UniversalDashboard.Community -Force

#Download and Install ASP.net Core hosting bundle
$installerurl = "https://github.com/waynehoggett/AZ-300TestSite/raw/master/Install/dotnet-hosting-3.1.3-win.exe"
$installer = "C:\dotnet-hosting-3.1.3-win.exe"
Invoke-WebRequest -uri $installerurl -outfile $installer -UseBasicParsing
Start-Process -FilePath $installer -ArgumentList @('/install', '/quiet', '/norestart')

#Download website
$url = "https://github.com/waynehoggett/AZ-300TestSite/raw/master/Install/backup.zip"
$zipfile = "C:\backup.zip"
$folder = "C:\inetpub\wwwroot"
Invoke-WebRequest -uri $url -outfile $zipfile -UseBasicParsing

#Extract and install website
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $folder)

#Clean-up
Remove-Item -Path $zipfile -Force
Remove-Item -Path $installer -Force