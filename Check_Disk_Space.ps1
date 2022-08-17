Function Write-Log 
{
[CmdletBinding()]
    Param(
            [Parameter(Mandatory=$False)]
            [ValidateSet("INFO","WARN","ERROR","FATAL","DEBUG")]
            [String]
            $Level = "INFO",
            [Parameter(Mandatory=$True)]
            [string]
            $Message,
            [Parameter(Mandatory=$False)]
            [string]
            $logfile
        )

        $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
        $date = (Get-Date).toString("yyyy-MM-dd")
        $content = "[$Stamp] [$Level] $Message"

        if($logfile)
        {
            $logfile+="_"+$date
            $logfile+=".log"
            Add-Content $logfile -Value $content
        }
        else
        {
            Write-Output $content
        }
}

function Get-CurrentLineNumber
{
    $MyInvocation.ScriptLineNumber
}
    $ScriptDirectory = "C:\Share\" 
    $InstallerLogFileName="$ScriptDirectory\Specified_free_disk.log"


$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size, FreeSpace

$specified_space = 50

$disk_space =  ("{0}" -f [math]::truncate($disk.Size / 1GB))

$free_space =  ("{0}" -f [math]::truncate($disk.FreeSpace / 1GB))

 Write-Log "INFO" "[$(Get-CurrentLineNumber)]  'Total Disk Space: $disk_space' "$InstallerLogFileName""
 Write-Log "INFO" "[$(Get-CurrentLineNumber)]  'Free Space in disk: $free_space' "$InstallerLogFileName""
 Write-Log "INFO" "[$(Get-CurrentLineNumber)]  'Specified Free Disk: $specified_space' "$InstallerLogFileName""

$specified_space = $specified_space -as [int]

$disk_space = $disk_space -as [int]

if($specified_space -gt $free_space)
{
   Write-Log "INFO" "[$(Get-CurrentLineNumber)]  'Spacified disk is greater than free space.' "$InstallerLogFileName""
}
elseif($specified_space -eq $free_space)
{
   Write-Log "INFO" "[$(Get-CurrentLineNumber)]  'Spacified disk space is equal to disk space.' "$InstallerLogFileName""
}
else
{
    Write-Log "INFO" "[$(Get-CurrentLineNumber)]  'Spacified disk is less than free space.' "$InstallerLogFileName""
}