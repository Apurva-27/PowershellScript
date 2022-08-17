$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size, FreeSpace
Write-Host "Please enter the specified free space"
$freediskspace = Read-Host
$disk_space =  ("{0}" -f [math]::truncate($disk.Size / 1GB))
$diskfree_space =  ("{0}" -f [math]::truncate($disk.FreeSpace / 1GB))
Write-Host $disk_space
Write-Host $diskfree_space
Write-Host $freediskspace
$freediskspace = $freediskspace -as [int]
$disk_space = $disk_space -as [int]
If($disk_space -gt $diskfree_space)
{
Write-host " Total disk is greater than specified free space"
}
elseif($freediskspace -eq $diskfree_space)
{
Write-Host "Total disk space is equal to specified disk space"
}
else
{
Write-host " Total disk is less than specified free space"
}