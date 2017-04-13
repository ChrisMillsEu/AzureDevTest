        # Add Tridion Core Service Firewall rule 
        Function Enable-TridionCoreServiceFirewall
        {
        $rulename = "Tridion Core Service net.tcp 2660"
            if (!(Get-NetFirewallRule -DisplayName $rulename -ErrorAction SilentlyContinue ))
            {
             New-NetFirewallRule -DisplayName $rulename -Direction Inbound -LocalPort 2660 -Protocol TCP -Action Allow
            }
        }
        Enable-TridionCoreServiceFirewall

        # Add Sql Firewall rules 
        Function Enable-SQLFirewall
        {
        $rulename = "SQL Inbound 1433"
            if (!(Get-NetFirewallRule -DisplayName $rulename -ErrorAction SilentlyContinue ))
            {
             New-NetFirewallRule -DisplayName $rulename -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow
            }
        $rulename = "SQL Dynamic Ports"
            if (!(Get-NetFirewallRule -DisplayName $rulename -ErrorAction SilentlyContinue ))
            {
                 New-NetFirewallRule -DisplayName $rulename -Direction Inbound -Program 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Binn\sqlservr.exe' -Protocol TCP -Action Allow
            }    

        }
        Enable-SQLFirewall

        #Add MSDTC firewall rules

        Function Enable-MSDTCFirewall
        {
            Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (RPC)" | Set-NetFirewallRule -Enabled True
            Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (RPC-EPMAP)" | Set-NetFirewallRule -Enabled True
            Get-NetFirewallRule -DisplayName "Distributed Transaction Coordinator (TCP-In)" | Set-NetFirewallRule -Enabled True
        }
        Enable-MSDTCFirewall

        # Add Ping rule
        Set-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -Enabled True