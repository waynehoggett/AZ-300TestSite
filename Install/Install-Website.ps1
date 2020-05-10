#Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools

#Add required types
Add-Type -AssemblyName System.IO.Compression.FileSystem

#Download website
$url = "https://github.com/waynehoggett/AZ-300TestSite/raw/master/Install/backup.zip"
$zipfile = "C:\backup.zip"
$folder = "C:\inetpub\wwwroot"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -uri $url -outfile $zipfile

#Extract and install website
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $folder)

#Clean-up
Remove-Item -Path $zipfile