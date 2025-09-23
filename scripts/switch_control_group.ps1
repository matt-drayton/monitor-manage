param(
    [Parameter(Mandatory=$true)][string]$controlGroup
)

$audioDeviceName = (Get-Content -Path  "$([Environment]::GetFolderPath("MyDocuments"))/monitor-manage/config.json" | ConvertFrom-Json).$controlGroup.audio
$audioDeviceIndex = (Get-AudioDevice -List | Where-Object { $_.Name -eq $audioDeviceName }).Index

Set-AudioDevice -Index $audioDeviceIndex
