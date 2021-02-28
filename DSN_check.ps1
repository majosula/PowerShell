#DNS check
#GET DNS IPs
$DNS = Get-DnsClientServerAddress| where {$_.InterfaceAlias -like "*Ether*" -and $_.ServerAddresses -ne ""} | select -Property ServerAddresses
$IPS = $DNS.ServerAddresses

#write your DNS IPs into console
Write-Host "Your DNS are:" -ForegroundColor Yellow
$IPS

#for each DNS test connection on port 53 and write output
foreach ($IP in $IPS)
    {
        $testConnection = Test-NetConnection $IP -Port 53 -InformationLevel Quiet

     if ($testConnection -eq "True")
        {
            Write-Host -ForegroundColor Green "DNS" $IP "is working fine. Connection  via port 53 is open."
        }

    else 
        {
            Write-Host -ForegroundColor red "DNS" $IP "is not workign properly"
        }
    }
