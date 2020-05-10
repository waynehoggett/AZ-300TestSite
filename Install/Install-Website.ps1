#Install IIS
Install-WindowsFeature -name 'Web-Server','Web-WebSockets' -IncludeManagementTools

#Download and Install ASP.net Core hosting bundle
$installerurl = ""
$installer = "C:\dotnet-hosting-3.1.3-win.exe"
Invoke-WebRequest -uri $installerurl -outfile $installer -UseBasicParsing

#Add required types
Add-Type -AssemblyName System.IO.Compression.FileSystem

#Download website
$url = "https://github.com/waynehoggett/AZ-300TestSite/raw/master/Install/backup.zip"
$zipfile = "C:\backup.zip"
$folder = "C:\inetpub\wwwroot"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -uri $url -outfile $zipfile -UseBasicParsing

#Extract and install website
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $folder)

#Clean-up
Remove-Item -Path $zipfile -Force
Remove-Item -Path $installer -Force