# Source
# https://emg.johnshopkins.edu/?p=804

#Create the Variable
$final = @()

#Import the CSV file with a column labeled 'name'.
$1 = Import-CSV C:\admin\users.csv
 
#Loop it for each entry
$1 | %{
$n = $_.name
$r = [bool](get-mailbox "$n")
$i = (get-mailbox "$n")

#Build the Array
 $ServerObj = New-Object PSObject
 $ServerObj | Add-Member NoteProperty -Name "EXO-Exists" -Value $r
 $ServerObj | Add-Member NoteProperty -Name "EXO-User" -Value $n
 $ServerObj | Add-Member NoteProperty -Name "EXO-Name" -Value $i.Name
 $ServerObj | Add-Member NoteProperty -Name "EXO-Alias" -Value $i.Alias
 $ServerObj | Add-Member NoteProperty -Name "EXO-PrimarySmtpAddress" -Value $i.PrimarySmtpAddress
 $ServerObj | Add-Member NoteProperty -Name "EXO-LitigationHoldEnabled" -Value $i.LitigationHoldEnabled
 $ServerObj | Add-Member NoteProperty -Name "EXO-LitigationHoldDate" -Value $i.LitigationHoldDate
   $Final += $ServerObj    
}

#Display the Results
$Final

#Export the CSV to a file
$Final | Export-csv C:\admin\EXO-Results_Users.csv -notype
