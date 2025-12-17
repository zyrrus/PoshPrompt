function Write-Outro {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Message)
    
    Write-Host (Format-AnsiText "│" -Style 'Dim')
    $symbolEnd = Format-AnsiText "└" -Style 'Dim'
    Write-Host "$symbolEnd  $Message`n"
}