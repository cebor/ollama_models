$port = 11434

# Firewall
if (-not (Get-NetFirewallRule -DisplayName "Ollama WSL2" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Ollama WSL2" `
      -Direction Inbound -Protocol TCP `
      -LocalPort $port -Action Allow
    Write-Host "Firewall rule created"
} else {
    Write-Host "Firewall rule already exists"
}

# WSL starten + am Leben halten
Write-Host "Starting WSL2..."
$wslJob = Start-Job -ScriptBlock {
    wsl -e bash -c "while true; do sleep 10; done"
}

# LAN-IP ermitteln (Interface mit Default Gateway = echte Netzwerkverbindung)
$lanIp = (Get-NetRoute -DestinationPrefix '0.0.0.0/0' |
    Sort-Object -Property RouteMetric |
    Select-Object -First 1 |
    Get-NetIPAddress -AddressFamily IPv4).IPAddress
if (-not $lanIp) {
    Write-Host "ERROR: No LAN IP found." -ForegroundColor Red
    exit 1
}
Write-Host "LAN IP: $lanIp"

# Portproxy: LAN-IP -> localhost (WSL2 localhost forwarding)
# Nur auf LAN-IP binden, nicht 0.0.0.0 — sonst Loop mit WSL localhost forwarding
netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$lanIp | Out-Null
netsh interface portproxy add v4tov4 `
  listenport=$port listenaddress=$lanIp `
  connectport=$port connectaddress=127.0.0.1

Write-Host "Forwarding $lanIp`:$port -> 127.0.0.1:$port (WSL2 localhost forwarding)"
Write-Host ""
Write-Host "Ollama is available on the network. Close this window to shut down."

try {
    while ($true) { Start-Sleep -Seconds 5 }
} finally {
    netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$lanIp | Out-Null
    Stop-Job $wslJob -ErrorAction SilentlyContinue
    Remove-Job $wslJob -ErrorAction SilentlyContinue
    wsl --shutdown
    Write-Host "WSL2 shut down."
}
