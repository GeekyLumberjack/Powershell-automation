Set-ExecutionPolicy RemoteSigned

$Computers = Get-Content "INPUT PATH"


[System.Collections.ArrayList]$gettoday1 = $(Get-Date) -split " "
[System.String]$gettoday = $gettoday1[0]
$errorindescription = $true

ForEach ($Computer in $Computers){

$ADComputer = Get-ADComputer $Computer -Properties Description 

    If ($ADComputer.Description -eq $null){
        Write-Host $Computer is NULL
        Set-ADComputer $Computer -Description "Computer last scanned on $($gettoday)"
        Write-Host "$Computer is now $ADComputer.Description"}

        Elseif($ADComputer.Description -Match 'last scanned on'){
            Write-Host $Computer contains --- last scanned on --- $ADComputer.Description
            [System.Array]$tempdescription = $ADComputer.Description -split " "
            Foreach($index in $tempdescription){
            if($index -like '??/??/*'){
                $foundindex = $tempdescription.IndexOf($index)
                $tempdescription[$foundindex] = $gettoday
                [System.String]$tempdescription = $tempdescription -join " "
                Write-Host $tempdescription
                Set-ADComputer $Computer -Description $($tempdescription)
                Write-Host $Computer is now $tempdescription
                $errorindescription = $false
                Break
            }
            }
            if($errorindescription -eq $true){
            Write-Host $Computer had a description error, this script could not change the field properly. You must manually edit this computers description.
            }
            }

            Else{
              $tempdescription = $ADComputer.Description
              Write-Host $Computer no --- last scanned on ---- Date added to front - $ADComputer.Description 
              Set-ADComputer $Computer -Description "Computer last scanned on $($gettoday), $($tempdescription)"
              Write-Host $Computer is now Computer last scanned on $($gettoday), $($tempdescription)
               }      
}
