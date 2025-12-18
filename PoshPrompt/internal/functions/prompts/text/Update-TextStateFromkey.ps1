function Update-TextStateFromKey {
    param(
        [hashtable]$State,
        [System.ConsoleKeyInfo]$Key,
        [scriptblock]$Validate = $null
    )

    $newState = $State.Clone()

    switch ($Key.Key) {
        'Escape' { $newState.Status = [PromptStatus]::Cancelled }
        'C' { 
            if ($Key.Modifiers -band [ConsoleModifiers]::Control) {
                $newState.Status = [PromptStatus]::Cancelled
            }
        }
        'Enter' {
            if ($Validate) {
                $err = & $Validate $newState.Value
                if ($err) { $newState.Status = [PromptStatus]::Error; $newState.Feedback = $err }
                else { $newState.Status = [PromptStatus]::Submitted }
            }
            else { $newState.Status = [PromptStatus]::Submitted }
        }
        'LeftArrow' { if ($newState.CursorPosition -gt 0) { $newState.CursorPosition-- } }
        'RightArrow' { if ($newState.CursorPosition -lt $newState.Value.Length) { $newState.CursorPosition++ } }
        'Backspace' {
            if ($newState.CursorPosition -gt 0) {
                $before = $newState.Value.Substring(0, $newState.CursorPosition - 1)
                $after = $newState.Value.Substring($newState.CursorPosition)
                $newState.Value = $before + $after
                $newState.CursorPosition--
            }
        }
        'Delete' {
            if ($newState.CursorPosition -lt $newState.Value.Length) {
                $before = $newState.Value.Substring(0, $newState.CursorPosition)
                $after = $newState.Value.Substring($newState.CursorPosition + 1)
                $newState.Value = $before + $after
            }
        }
        default {
            if (-not [char]::IsControl($Key.KeyChar)) {
                $before = $newState.Value.Substring(0, $newState.CursorPosition)
                $after = $newState.Value.Substring($newState.CursorPosition)
                $newState.Value = $before + $Key.KeyChar + $after
                $newState.CursorPosition++
            }
        }
    }

    return $newState
}