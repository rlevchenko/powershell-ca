<#
.Description
       Installs required server roles for Root CA including Web Enrollment.
       + very simple test 

.NOTES
       Name: CA Installation
       Author : Roman Levchenko
       WebSite: www.rlevchenko.com
       Prerequisites: domain infrastructure, defined args

#>

#Variables
$pass = $args[0] #VMM argument
$domain = (gwmi WIN32_ComputerSystem).Domain
$secpass = convertto-securestring $pass -asplaintext -force
$credential = New-Object System.Management.Automation.PsCredential -ArgumentList "$domain\Administrator", $secpass
#CA+WE
Install-ADCSCertificationAuthority -CAType EnterpriseRootCA -Credential $credential -Confirm:$false
Install-ADcsWebEnrollment -Credential $credential -Force
#Simple test
$test = (Get-WebVirtualDirectory).path
If ($test -eq "/CertEnroll") { "CAWE WAS INSTALLED SUCCESSFULLY" }