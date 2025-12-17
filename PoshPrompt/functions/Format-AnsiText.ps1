$Script:AnsiCodes = @{
    Foreground = @{
        Black = 30; Red = 31; Green = 32; Yellow = 33;
        Blue = 34; Magenta = 35; Cyan = 36; White = 37
    }
    Background = @{
        Black = 40; Red = 41; Green = 42; Yellow = 43;
        Blue = 44; Magenta = 45; Cyan = 46; White = 47
    }
    Style      = @{
        Bold = 1; Dim = 2; Italic = 3; Underline = 4;
        Blink = 5; Inverse = 7; Hidden = 8; StrikeThrough = 9
    }
}

function Format-AnsiText {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)][string]$Text,
        [ValidateSet("Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White")][string]$Foreground,
        [ValidateSet("Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White")][string]$Background,
        [ValidateSet("Bold", "Dim", "Italic", "Underline", "Blink", "Inverse", "Hidden", "StrikeThrough")][string[]]$Style
    )

    $codes = @()

    if ($Style) {
        foreach ($s in $Style) {
            $codes += $Script:AnsiCodes.Style[$s]
        }
    }

    if ($Foreground) {
        $codes += $Script:AnsiCodes.Foreground[$Foreground]
    }

    if ($Background) {
        $codes += $Script:AnsiCodes.Background[$Background]
    }

    if ($codes.Count -eq 0) { return $Text }

    $esc = [char]0x1b
    $start = "$esc[$($codes -join ';')m"
    $reset = "$esc[0m"
    return "$start$Text$reset"
}