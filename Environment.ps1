# container
$ContainerName = 'DependencyGraph'
$licenseFile = 'C:\License\Dev.bclicense'

# Image
$artifactUrl = Get-BCArtifactUrl -country "es" -version 25  

# User
$UserName = 'User'
$Password = ConvertTo-SecureString "Pass123" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)
			
New-BCContainer -accept_eula `
                -accept_outdated `
                -updateHosts `
                -containername $containername `
   		        -artifactUrl $artifactUrl `
                -auth NavUserPassword `
                -Credential $credential `
                -isolation hyperv `
                -includeTestToolkit