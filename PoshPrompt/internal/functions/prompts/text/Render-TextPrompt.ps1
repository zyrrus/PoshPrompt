function Render-TextPrompt {
    param([hashtable]$State, [string]$Message, [string]$Placeholder)

    $symbol = Get-Symbol -State $State
    $symbolBar = Get-SymbolColored -Symbol "│" -State $State
    $symbolEnd = Get-SymbolColored -Symbol "└" -State $State

    $inputField = if ($State.Value) { Get-ValueWithCursor -State $State }
    elseif ($Placeholder -and $Placeholder.Length -gt 0) {
        $head = Format-AnsiText $Placeholder.Substring(0, 1) -Style 'Inverse'
        $tail = if ($Placeholder.Length -gt 1) { Format-AnsiText $Placeholder.Substring(1) -Style 'Dim' } else { '' }
        $head + $tail
    }
    else { Format-AnsiText ' ' -Style 'Inverse' }

    $prompt = "$symbol  $Message"

    switch ($State.Status) {
        Submitted {
            $prompt += "`n$symbolBar  $(Format-AnsiText $State.Value -Style 'Dim')"
            $prompt += "`n$symbolBar"
        }
        Cancelled {
            $prompt += "`n$symbolBar"
            $prompt += "`n$symbolEnd"
        }
        Error {
            $prompt += "`n$symbolBar  $inputField"
            $prompt += "`n$symbolEnd  $(Format-AnsiText $State.Feedback -Foreground 'Yellow')"
        }
        Default {
            $prompt += "`n$symbolBar  $inputField"
            $prompt += "`n$symbolEnd"
        }
    }

    return $prompt
}
