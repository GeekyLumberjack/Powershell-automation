﻿# input file

$findsheet = "INPUTFILE"

$blankips = Get-Content $findsheet

$outputfile = 'OUTPUTFILE'

$report = @()

foreach ($blankip in $blankips) {
        
        $IPname = $null
        $IPname1 = $null
           if ($IPname = Get-DhcpServerv4Reservation -ComputerName "DHCPSERVER ADDRESS" -IPAddress $blankip -ErrorAction SilentlyContinue) {
            $namefound = $IPname.Name
            $MACfound = $IPname.ClientId
            $IPnamefound = New-Object PSObject
            $IPnamefound | Add-Member NoteProperty 'IP Address:' $blankip
            $IPnamefound | Add-Member NoteProperty 'NetBIOS Name:' $namefound
            $IPnamefound | Add-Member NoteProperty 'MAC:' $MACfound
            $report += $IPnamefound
            }
           Elseif ($IPname1 = Get-DhcpServerv4Lease -ComputerName "DHCPSERVER ADDRESS" -IPAddress $blankip -ErrorAction SilentlyContinue) {
           $namefound1 = $IPname1.Name
           $MACfound1 = $IPname1.ClientId
           $IPnamefound1 = New-Object PSObject
           $IPnamefound1 | Add-Member NoteProperty 'IP Address:' $blankip
           $IPnamefound1 | Add-Member NoteProperty 'NetBIOS Name:' $namefound1
           $IPnamefound1 | Add-Member NoteProperty 'MAC:' $MACfound1
           $report += $IPnamefound1
           }
            }
$report | Export-Csv -NoTypeInformation $outputfile
