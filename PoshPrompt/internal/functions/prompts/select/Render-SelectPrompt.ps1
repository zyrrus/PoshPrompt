function Render-SelectPrompt {
    param([hashtable]$State, [string]$Message, [string[]]$Options)

    $symbol = Get-Symbol -State $State
    $symbolBar = Get-SymbolColored -Symbol "│" -State $State
    $symbolEnd = Get-SymbolColored -Symbol "└" -State $State

    $prompt = "$symbol  $Message"

    $renderOptions = {
        param($state)
        $out = ""
        for ($i = 0; $i -lt $Options.Count; $i++) {
            $out += "`n$symbolBar  "
            if ($i -eq $state.SelectedIndex) {
                $out += "$(Format-AnsiText '●' -Foreground 'Green') $($Options[$i])"
            }
            else {
                $out += (Format-AnsiText "○ $($Options[$i])" -Style 'Dim')
            }
        }
        return $out
    }

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