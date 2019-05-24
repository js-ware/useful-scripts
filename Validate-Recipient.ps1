# Source
# https://emg.johnshopkins.edu/?p=804

#Create the Variable
$final = @()

#Import the CSV file with a column labeled 'name'.
$1 = Import-CSV C:\admin\users.csv
 
#Loop it for each entry
$1 | %{
$n = $_.name
$r = [bool](get-recipient "$n")
$i = (get-recipient "$n")

#Build the Array
 $ServerObj = New-Object PSObject
 $ServerObj | Add-Member NoteProperty -Name "Exists" -Value $r
 $ServerObj | Add-Member NoteProperty -Name "User" -Value $n
 $ServerObj | Add-Member NoteProperty -Name "Recipient-Name" -Value $i.Name
 $ServerObj | Add-Member NoteProperty -Name "samAccountName" -Value $i.samAccountName
 $ServerObj | Add-Member NoteProperty -Name "Alias" -Value $i.Alias
 $ServerObj | Add-Member NoteProperty -Name "PrimarySmtpAddress" -Value $i.PrimarySmtpAddress
 $ServerObj | Add-Member NoteProperty -Name "ExternalEmailAddress" -Value $i.ExternalEmailAddress
 $ServerObj | Add-Member NoteProperty -Name "RecipientTypeDetails" -Value $i.RecipientTypeDetails
 $ServerObj | Add-Member NoteProperty -Name "OrganizationalUnit" -Value $i.OrganizationalUnit
     $Final += $ServerObj    
}

#Display the Results
$Final

#Export the CSV to a file
$Final | Export-csv C:\admin\Results_Users.csv -notype
