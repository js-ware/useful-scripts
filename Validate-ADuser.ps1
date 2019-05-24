# Source
# https://emg.johnshopkins.edu/?p=804
# help on how to use get-ADUser correctly from:
#   https://www.powershelladmin.com/wiki/Check_if_an_AD_user_exists_with_Get-ADUser

#Create the Variable
$final = @()

#Import the CSV file with a column labeled 'name'.
$1 = Import-CSV C:\admin\users.csv
 
#Loop it for each entry
$1 | %{
$n = $_.name
$r = [bool](get-ADUser -Filter {SamAccountName -eq $n} -Server ADDC-01.example.com)
$i = (get-ADUser -Filter {SamAccountName -eq $n} -Server ADDC-01.example.com)

#Build the Array
 $ServerObj = New-Object PSObject
 $ServerObj | Add-Member NoteProperty -Name "NA-Exists" -Value $r
 $ServerObj | Add-Member NoteProperty -Name "NA-User" -Value $n
 $ServerObj | Add-Member NoteProperty -Name "NA-AD-Name" -Value $i.Name
 $ServerObj | Add-Member NoteProperty -Name "NA-UserPrincipalName" -Value $i.UserPrincipalName
 $ServerObj | Add-Member NoteProperty -Name "NA-samAccountName" -Value $i.samAccountName
 $ServerObj | Add-Member NoteProperty -Name "NA-DistinguishedName" -Value $i.DistinguishedName
     $Final += $ServerObj    
}

#Display the Results
$Final

#Export the CSV to a file
$Final | Export-csv C:\admin\AD-Results_Users.csv -notype
