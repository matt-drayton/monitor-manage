param(
    [Parameter(Mandatory=$true)][string]$controlGroup
)

$config = (Get-Content -Path  "$([Environment]::GetFolderPath("MyDocuments"))/monitor-manage/config.json" | ConvertFrom-Json)

# Enable and disable monitors
$displaysToEnable = $config.$controlGroup.activeDisplays
$displaysToDisable = $config.$controlGroup.disableDisplays

foreach ($display in $displaysToEnable) {
    $displayIndex = (Get-DisplayInfo | Where-Object {$_.DisplayName -eq $display}).DisplayId
    Enable-Display $displayIndex
}


foreach ($display in $displaysToDisable) {
    $displayIndex = (Get-DisplayInfo | Where-Object {$_.DisplayName -eq $display}).DisplayId
    Disable-Display $displayIndex
}

# Set audio device
$audioDeviceName = $config.$controlGroup.audio
$audioDeviceIndex = (Get-AudioDevice -List | Where-Object { $_.Name -eq $audioDeviceName }).Index

Set-AudioDevice -Index $audioDeviceIndex
