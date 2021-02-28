#### get current usage of CPU 
#Declare variables
$collectData = @()
$i = 0
$line = "-----------------------------------"

#collect utilization data
do  {
    $CPU = Get-WmiObject win32_processor | Measure-Object -Property LoadPercentage -Average | select average
    $collectData += $CPU.Average
    Start-Sleep -s 2
    $i ++
    }
until ($i -eq 3)

#average utilization from last minute
    $b = $collectData |  Measure-Object -Average | select average
    Write-Host  "average CPU utlization from last minute is :" $b.Average "% "

#hostname of computer
    Write-Host $line 
    hostname

#last reboot of server
    Write-Host $line
    Write-Host "Last reboot of system"
    Systeminfo | findstr Boot
    Write-Host $line

#Processor data
    $processors= gwmi win32_processor | select NumberOfLogicalProcessors
    $CountSockets = $processors.Count
    $CoresSelect = $processors | select -First 1
    $CoresNumber = $CoresSelect.NumberOfLogicalProcessors
    $vCPU = $CoresNumber * $CountSockets    
    Write-Host $line
    Write-Host "Processor data"
    Write-Host $line
    Write-host "Number of total vCPU = " $vCPU
    write-host "Number of sockets = " $CountSockets
    Write-Host  "Number of Cores per socket = " $CoresNumber 

#Processes which are consuming most of utilization
    Write-Host $line
    Write-Host  "List of 15 processes which are taking most of CPU :"
    Write-Host $line
    Get-Process | Select -first 15 | Sort CPU -descending | format-list Name, CPU , StartTime, Product ,Path 

#Users session on system
    Write-Host $line
    Write-Host  "List of users session on server:"
    Write-Host $line
    quser

