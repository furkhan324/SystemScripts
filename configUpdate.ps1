#v1 of script to update config file
#names of machines to be updated are hardcoded into the script
#also requires Enable-PSremoting on both client and server machines via GP
#I'll push out a new update today that reads computers from a query on the Active Directory itself and does not need hardcoding of machine list


$machinesToBeUpdated = @("exComputer1","exComputer2","exComputer3","exComputer4");

$username = "testdomain.local\furkhan324"
$password = cat C:\securestring.txt | convertto-securestring

$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $username, $password


         foreach ($machine in $machinesToBeUpdated) {
			Invoke-Command -computerName $machine -ScriptBlock { 
				copy \\<UNC_PATH_TO_SHARED_FILE>\newConfigFile.CONFIG C:\<LOCAL_PATH_TO_OLD_FILE>\oldConfigFile.CONFIG

			 } -credential $cred

         }


exit
