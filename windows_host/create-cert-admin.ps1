Add-Type -AssemblyName 'System.Web'
# Admin Ansible user
$ansibleRunnerUsername = 'Administrator'
$password = 'd=KIJR.(f!p;)(RFf@Jy5y&E%oR.Y$yT'
$ansibleRunnerPassword = (ConvertTo-SecureString -String $password -AsPlainText -Force)
# Map generated certificates to the ansible runner
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ansibleRunnerUsername, $ansibleRunnerPassword

# Find the cert thumbprint for the client certificate created on the Ansible host
$ansibleCert = Get-ChildItem -Path 'Cert:\LocalMachine\Root' | Where-Object {$_.Subject -eq 'CN=ansiblerunner'}

$params = @{
	Path = 'WSMan:\localhost\ClientCertificate'
	Subject = "$ansibleRunnerUsername@localhost"
	URI = '*'
	Issuer = $ansibleCert.Thumbprint
  Credential = $credential
	Force = $true
}
New-Item @params