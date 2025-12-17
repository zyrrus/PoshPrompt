function Render-ConfirmPrompt {
    param([hashtable]$State, [string]$Message, [bool]$DefaultValue)

    $symbol = Get-Symbol -State $State
    $symbolBar = Get-SymbolColored -Symbol "│" -State $State
    $symbolEnd = Get-SymbolColored -Symbol "└" -State $State

    $prompt = "$symbol  $Message"

    $renderOptions = {
        param($state)
        $out = "`n$symbolBar  "
        if ($state.Value -eq 'y') {
            $out += "$(Format-AnsiText '●' -Foreground 'Green') Yes $(Format-AnsiText '/ ○ No' -Style 'Dim')"
        }
        else {
            $out += "$(Format-AnsiText '○ Yes /' -Style 'Dim') $(Format-AnsiText '●' -Foreground 'Green') No"
        }
        return $out
    }

    switch ($State.Status) {
        Submitted {
            $answer = if ($State.Value -eq 'y') { 'Yes' } else { 'No' }
            $prompt += "`n$symbolBar  $(Format-AnsiText $answer -Style 'Dim')"
            $prompt += "`n$symbolBar"
        }
        Cancelled {
            $prompt += "`n$symbolBar"
            $prompt += "`n$symbolEnd"
        }
        Error {
            $prompt += & $renderOptions $State
            $prompt += "`n$symbolEnd  $(Format-AnsiText $State.Feedback -Foreground 'Yellow')"
        }
        Default {
            $prompt += & $renderOptions $State
            $prompt += "`n$symbolEnd"
        }
    }

    return $prompt
}