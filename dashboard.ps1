Start-UDDashboard -Wait -Dashboard (
    New-UDDashboard -Title "Hello from $($env:COMPUTERNAME)" -Content {
        New-UDCard -Title "Hello from $($env:COMPUTERNAME)" -Content {
            New-UDButton -Text "Start CPU Stress" -Icon play -OnClick {
                Start-Process -FilePath '.\CPUSTRES.EXE' -ArgumentList '/accepteula'
            }
            New-UDButton -Text "Stop CPU Stress" -Icon stop -OnClick {
                Get-Process "CPUSTRES" | Stop-Process -Force
            }
            New-UDButton -Text "Kill Website" -Icon warning -OnClick {
                Start-Process -FilePath "iisreset" -ArgumentList "/stop"
            }
        }
    }
)