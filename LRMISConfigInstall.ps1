##########{INSTALL JRE FROM PACKAGE }##############

powershell start-process -filepath C:\Users\saad.mahmood\Desktop\jre-8u121-windows-i586.exe -passthru -wait -argumentlist "/s,INSTALLDIR=c:\progra~1\jre,/L,install64.log"


Copy-Item -Path  C:\Users\saad.mahmood\Desktop\JavaConfig\deployment.properties -Destination C:\Users\$env:UserName\AppData\LocalLow\Sun\Java\Deployment
Copy-Item -Path  C:\Users\saad.mahmood\Desktop\JavaConfig\exception.sites -Destination C:\Users\$env:UserName\AppData\LocalLow\Sun\Java\Deployment\security

