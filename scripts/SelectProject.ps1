Add-Type -AssemblyName System.Windows.Forms

$dialog = New-Object System.Windows.Forms.FolderBrowserDialog

$dialog.Description = "Select MPLAB Project Folder"
$dialog.ShowNewFolderButton = $false

$result = $dialog.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    Write-Output $dialog.SelectedPath
}