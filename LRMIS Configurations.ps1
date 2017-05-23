
    #Install Urdu Fonts

    function Install-FontUrdu
    {
        param(

        [string]$path 

        )

        $FONTS = 0x14
        $objShell = New-Object -ComObject Shell.Application
        $objFolder = $objShell.Namespace($FONTS)
        $objFolder.CopyHere($path)

    }

    #function call

    Install-FontUrdu "C:\Users\saad.mahmood\Desktop\Fonts\JameelNooriNastaleeq.ttf"
    Install-FontUrdu "C:\Users\saad.mahmood\Desktop\Fonts\JameelNooriNastaleeqKasheeda.ttf"


    #Set IE Home Page

    $path = 'HKCU:\Software\Microsoft\Internet Explorer\Main\'
    $name = 'start page'
    $value = 'https://clrmis.punjab-zameen.gov.pk/'
    Set-Itemproperty -Path $path -Name $name -Value $value


    #Clear All IE Cache Function -Param 

    function Clear-IECachedData
    {
	    [CmdletBinding(ConfirmImpact = 'None')]
	    param
	    (
		    [Parameter(Mandatory = $false,
				       HelpMessage = ' Delete Temporary Internet Files')]
		    [switch]
		    $TempIEFiles,
		    [Parameter(HelpMessage = 'Delete Cookies')]
		    [switch]
		    $Cookies,
		    [Parameter(HelpMessage = 'Delete History')]
		    [switch]
		    $History,
		    [Parameter(HelpMessage = 'Delete Form Data')]
		    [switch]
		    $FormData,
		    [Parameter(HelpMessage = 'Delete Passwords')]
		    [switch]
		    $Passwords,
		    [Parameter(HelpMessage = 'Delete All')]
		    [switch]
		    $All,
		    [Parameter(HelpMessage = 'Delete Files and Settings Stored by Add-Ons')]
		    [switch]
		    $AddOnSettings
	    )
	    if ($TempIEFiles) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8}
	    if ($Cookies) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2}
	    if ($History) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 1}
	    if ($FormData) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 16}
	    if ($Passwords) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 32 }
	    if ($All) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 255}
	    if ($AddOnSettings) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 4351 }
    }

    #Clear IE Cache -All

    Clear-IECachedData -All 

    #Add to Exception List of Java Settings

        $OS = (Get-WmiObject -class Win32_OperatingSystem).Caption
    if ($OS.Contains("7")) {
	    Add-Content -Path "$env:USERPROFILE\AppData\LocalLow\Sun\Java\Deployment\security\exception.sites" -Value "https://clrmis.punjab-zameen.gov.pk/"
    } else {
	    Add-Content -Path "$env:USERPROFILE\Application Data\Sun\Java\Deployment\security\exception.sites" -Value "https://10.0.5.131/"
}


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

