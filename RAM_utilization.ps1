#### get current usage of RAM

$ComputerMemory = Get-WmiObject -Class win32_operatingsystem -ErrorAction Stop
$Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
$RoundMemory = [math]::Round($Memory, 2)

Write-Host "Memmorry utilization is" $RoundMemory "%"
Write-Host "-----------------------------------" `n 


### get allocated RAM resourcies

$PysicalMemory = Get-WmiObject -class "win32_physicalmemory" -namespace "root\CIMV2"
Write-Host "Server has allocated $((($PysicalMemory).Capacity | Measure-Object -Sum).Sum/1GB)GB of RAM" 
Write-Host "-----------------------------------" `n 


# get first 15 process which taken most of RAM usage

Write-Host "List of first 15 processes which taken most of RAM usage"
Get-Process | Sort-Object WS -descending | select -First 15 | fl Name, WS , StartTime , Path , Product