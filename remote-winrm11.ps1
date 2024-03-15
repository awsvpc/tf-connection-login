$ips = $args[0]

Foreach ($ip in $ips) {
  $Username = '{0}\Administrator' -f $ip
  $Password = '${password}'
  $pass = ConvertTo-SecureString -AsPlainText $Password -Force
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
  
  Set-Item wsman:\localhost\client\trustedhosts $ip -Confirm:$false -Force
  Invoke-Command -ComputerName $ip -ScriptBlock { Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) } -credential $Cred
  Invoke-Command -ComputerName $ip -ScriptBlock { C:/ProgramData/chocolatey/choco install git -y } -credential $Cred
}
