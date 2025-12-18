function Render-MultiSelectPrompt {
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

            $params = @{ Style = 'Dim' }
            $box = '◻'
            if ($state.SelectedIndices.Contains($i)) {
                $params = @{ Foreground = 'Green' }
                $box = '◼'
            }
            elseif ($i -eq $state.HoveredIndex) {
                $params = @{ Foreground = 'Cyan' }
            }
            $out += "$(Format-AnsiText $box @params) "

            $params = if ($i -eq $state.HoveredIndex) { @{} } else { @{ Style = 'Dim' } }
            $out += "$(Format-AnsiText $Options[$i] @params)"
        }
        return $out
    }

    switch ($State.Status) {
        Submitted {
            $prompt += "`n$symbolBar  $(Format-AnsiText $($State.Value -join ", ") -Style 'Dim')"
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