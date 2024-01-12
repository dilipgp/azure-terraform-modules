param (
  [Parameter(ValuefromPipeline=$true,Mandatory=$true)]
  [string]$NR_API_KEY
)

# Update the SSL/TLS Version
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Install New Relic agent
(New-Object System.Net.WebClient).DownloadFile("https://download.newrelic.com/infrastructure_agent/windows/newrelic-infra.msi", "$env:TEMP\newrelic-infra.msi"); ` msiexec.exe /qn /i "$env:TEMP\newrelic-infra.msi" GENERATE_CONFIG=true LICENSE_KEY=$NR_API_KEY | Out-Null; ` net start newrelic-infra