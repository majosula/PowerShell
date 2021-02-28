

$servers = "localhost", "Server_one","Server_two" 

foreach ($Server in $servers)
{
    Invoke-Command -ComputerName $Server 
    {
        $service = get-service -name  VMAuthdService
        $hostname = hostname
        Write-Host -ForegroundColor Magenta  $hostname


        If ($service.status -eq "Stopped")
            {
             $service | start-service
             write-host -ForegroundColor Yellow $service.name "service has been started";
             $service 
            }

        elseif ($service.status -eq "Running")
            {
             write-host -ForegroundColor Green $service.name "service is running";
             $service
            }


        ### Check if value of ,,restart service after" in properties of service in recovery TAB is set to 1 minute

        $serviceDelayRestart = sc.exe qfailure VMAuthdService


        If ($serviceDelayRestart -match "RESTART -- Delay = 60000 milliseconds")
            {
             Write-Host -ForegroundColor green "Value restart service is already set to 1minute in service properties - Recovery TAB" 
             $serviceDelayRestart            
            }

        else{
             sc.exe failure VMAuthdService reset= 0 actions= restart/60000
             Write-Host -ForegroundColor yellow "Value restart service after has been set to 1minute in service properties - Recovery TAB"
             $serviceDelayRestart    
            }
    }
}
