
function Set-TimeZone {

  [CmdletBinding(SupportsShouldProcess = $True)]

  param(

    [Parameter(ValueFromPipeline = $False, ValueFromPipelineByPropertyName = $True, Mandatory = $False)]

    [ValidateSet("Dateline Standard Time","UTC-11","Hawaiian Standard Time","Alaskan Standard Time","Pacific Standard Time (Mexico)","Pacific Standard Time","US Mountain Standard Time","Mountain Standard Time (Mexico)","Mountain Standard Time","Central America Standard Time","Central Standard Time","Central Standard Time (Mexico)","Canada Central Standard Time","SA Pacific Standard Time","Eastern Standard Time","US Eastern Standard Time","Venezuela Standard Time","Paraguay Standard Time","Atlantic Standard Time","Central Brazilian Standard Time","SA Western Standard Time","Pacific SA Standard Time","Newfoundland Standard Time","E. South America Standard Time","Argentina Standard Time","SA Eastern Standard Time","Greenland Standard Time","Montevideo Standard Time","Bahia Standard Time","UTC-02","Mid-Atlantic Standard Time","Azores Standard Time","Cape Verde Standard Time","Morocco Standard Time","UTC","GMT Standard Time","Greenwich Standard Time","W. Europe Standard Time","Central Europe Standard Time","Romance Standard Time","Central European Standard Time","W. Central Africa Standard Time","Namibia Standard Time","Jordan Standard Time","GTB&nbsp;Standard Time","Middle East Standard Time","Egypt Standard Time","Syria Standard Time","E. Europe Standard Time","South Africa Standard Time","FLE&nbsp;Standard Time","Turkey Standard Time","Israel Standard Time","Arabic Standard Time","Kaliningrad Standard Time","Arab Standard Time","E. Africa Standard Time","Iran Standard Time","Arabian Standard Time","Azerbaijan Standard Time","Russian Standard Time","Mauritius Standard Time","Georgian Standard Time","Caucasus Standard Time","Afghanistan Standard Time","Pakistan Standard Time","West Asia Standard Time","India Standard Time","Sri Lanka Standard Time","Nepal Standard Time","Central Asia Standard Time","Bangladesh Standard Time","Ekaterinburg Standard Time","Myanmar Standard Time","SE Asia Standard Time","N. Central Asia Standard Time","China Standard Time","North Asia Standard Time","Singapore Standard Time","W. Australia Standard Time","Taipei Standard Time","Ulaanbaatar Standard Time","North Asia East Standard Time","Tokyo Standard Time","Korea Standard Time","Cen. Australia Standard Time","AUS Central Standard Time","E. Australia Standard Time","AUS Eastern Standard Time","West Pacific Standard Time","Tasmania Standard Time","Yakutsk&nbsp;Standard Time","Central Pacific Standard Time","Vladivostok Standard Time","New Zealand Standard Time","UTC+12","Fiji Standard Time","Magadan&nbsp;Standard Time","Tonga Standard Time","Samoa Standard Time")]

    [ValidateNotNullOrEmpty()]

    [string]$TimeZone = "Eastern Standard Time"

  )
 

  $process = New-Object System.Diagnostics.Process

  $process.StartInfo.WindowStyle = "Hidden"

  $process.StartInfo.FileName = "tzutil.exe"

  $process.StartInfo.Arguments = "/s `"$TimeZone`""

  $process.Start() | Out-Null

}
# end function Set-TimeZone

#######{SET TIME ZONE TO PKT}#######

# Set timezone to Pakistan Standard Time for Time Sync Issue 
Set-TimeZone "Pakistan Standard Time"

####### {FIREFOX DOWNLOAD & INSTALL } ########

# Path for the workdir
$workdir = "c:\installer\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer

$source = "https://download.mozilla.org/?product=firefox-51.0.1-SSL&os=win64&lang=en-US"
$destination = "$workdir\firefox.exe"

# Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Start the installation

Start-Process -FilePath "$workdir\firefox.exe" -ArgumentList "/S"

# Wait XX Seconds for the installation to finish

Start-Sleep -s 35

# Remove the installer

rm -Force $workdir\firefox*


##########{INSTALL JRE FROM PACKAGE }##############

powershell start-process -filepath C:\Users\saad.mahmood\Desktop\jre-8u121-windows-i586.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\progra~1\jre,/L,install64.log"

Start-Sleep -s 10

#Copy Java Libs to respective Destonation


#Destination URL for Jar Libs Copy 
$Dest = 'E:\'

Copy-Item -Path C:\Users\saad.mahmood\Desktop\commons-logging-1.2.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\dpfpenrollment.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\dpfpverification.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\dpjavapos.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\dpotapi.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\commons-codec-1.9.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\dpotjni.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\jpos113.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\httpcore-4.4.3.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\httpclient-cache-4.5.1.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\httpclient-4.5.1.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\gson-2.4.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\fluent-hc-4.5.1.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\dpuareu.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\xercesImpl-2.6.2.jar -Destination $Dest
Copy-Item -Path C:\Users\saad.mahmood\Desktop\xmlParserAPIs.jar -Destination $Dest

#Copy Java Configurations
Copy-Item -Path  C:\Users\saad.mahmood\Desktop\JavaConfig\deployment.properties -Destination C:\Users\$env:UserName\AppData\LocalLow\Sun\Java\Deployment
Copy-Item -Path  C:\Users\saad.mahmood\Desktop\JavaConfig\exception.sites -Destination C:\Users\$env:UserName\AppData\LocalLow\Sun\Java\Deployment\security


########{INSTALL DIGITAL PERSONA AND RESTARTS THE PC}###########

powershell  Start-Process "C:\Users\saad.mahmood\Desktop\Configs\BiometricPrerequisites\Digital\setup.exe" -passthru -wait -argumentlist "/norestart"





