function Write-Intro {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Title)
    
    $symbolStart = Format-AnsiText "┌" -Style 'Dim'
    $intro = Format-AnsiText " $Title " -Foreground 'Cyan' -Style 'Inverse'
    Write-Host "`n$symbolStart  $intro"
    Write-Host (Format-AnsiText "│" -Style 'Dim')
}