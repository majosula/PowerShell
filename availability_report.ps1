
###################
# MUTIPLE SERVERS #
###################

$servers = Get-Content -Path 'C:\temp\servers.txt'


foreach ($server in $servers)
{

$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@


$hostname = (Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $server ).Name

#Date is in format Month/Day/Year
$StartDate = [datetime]”2/1/2021”
$EndDate = [datetime]”2/28/2021”

$events = Get-WinEvent -ComputerName $server -FilterHashtable @{logname="system"; id=1074,6005,6006,6009,6013} | where { $_.timecreated -gt $StartDate -and $_.timecreated -lt $EndDate } | select -Property TimeCreated,message,ProviderName

$report = $events | ConvertTo-Html -Head "$Header" -Body "$hostname $events" -Title "Availabilty report" -PostContent "<p>Creation Date: $(Get-Date)<p>"
$report | Out-File -FilePath C:\temp\report.htm -Force -Append

 }



###################
#  SINGLE SERVER  #
###################


$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@


$hostname = (Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $server ).Name
$ComputerName = "<h1>Computer name: $env:computername </h1>"

#Date is in format Month/Day/Year
$StartDate = [datetime]”2/10/2021 12:00:00 PM”
$EndDate = [datetime]”3/1/2021 12:00:00 PM”


$events = Get-WinEvent -ComputerName DEFRSRV132 -FilterHashtable @{logname="system"; id=1074,6005,6006,6009,6013} | where { $_.timecreated -gt $StartDate -and $_.timecreated -lt $EndDate } | select -Property TimeCreated,message,ProviderName

$report = $events | ConvertTo-Html -Head "$Header" -Body "$ComputerName $events" -Title "Availabilty report" -PostContent "<p>Creation Date: $(Get-Date)<p>"
$report | Out-File -FilePath C:\temp\report.htm -Force -Append

