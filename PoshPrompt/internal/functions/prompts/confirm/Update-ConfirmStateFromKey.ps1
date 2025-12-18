function Update-ConfirmStateFromKey {
    param([hashtable]$State, [System.ConsoleKeyInfo]$Key)

    $newState = $State.Clone()

    switch ($Key.Key) {
        'LeftArrow' { $newState.Value = 'y' }
        'RightArrow' { $newState.Value = 'n' }
        'Y' { $newState.Value = 'y'; $newState.Status = [PromptStatus]::Submitted }
        'N' { $newState.Value = 'n'; $newState.Status = [PromptStatus]::Submitted }
        'Enter' { $newState.Status = [PromptStatus]::Submitted }
        'Escape' { $newState.Status = [PromptStatus]::Cancelled }
        'C' { 
            if ($Key.Modifiers -band [ConsoleModifiers]::Control) {
                $newState.Status = [PromptStatus]::Cancelled
            }
        }
    }

    return $newState
}