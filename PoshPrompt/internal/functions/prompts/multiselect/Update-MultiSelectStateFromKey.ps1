function Update-MultiSelectStateFromKey {
    param(
        [hashtable]$State,
        [System.ConsoleKeyInfo]$Key,
        [string[]]$Options,
        [scriptblock]$Validate = $null
    )

    $newState = $State.Clone()
    if (-not $newState.ContainsKey('HoveredIndex')) { $newState.HoveredIndex = 0 }
    if (-not $newState.ContainsKey('SelectedIndices')) { $newState.SelectedIndices = [System.Collections.Generic.HashSet[int]]::new() }

    switch ($Key.Key) {
        'UpArrow' { $newState.HoveredIndex = if ($newState.HoveredIndex -gt 0) { $newState.HoveredIndex - 1 } else { $Options.Count - 1 } }
        'DownArrow' { $newState.HoveredIndex = if ($newState.HoveredIndex -lt ($Options.Count - 1)) { $newState.HoveredIndex + 1 } else { 0 } }
        'Spacebar' { 
            if ($newState.SelectedIndices.Contains($newState.HoveredIndex)) { 
                [void]$newState.SelectedIndices.Remove($newState.HoveredIndex) 
            }
            else { 
                [void]$newState.SelectedIndices.Add($newState.HoveredIndex) 
            }
        }
        'Enter' { 
            $newState.Value = $Options[$newState.SelectedIndices] 
            if ($Validate) {
                $err = & $Validate $newState.Value
                if ($err) {
                    $newState.Status = [PromptStatus]::Error
                    $newState.Feedback = $err 
                }
                else { $newState.Status = [PromptStatus]::Submitted }
            }
            else { $newState.Status = [PromptStatus]::Submitted }
        }
        'Escape' { $newState.Status = [PromptStatus]::Cancelled }
        'C' { 
            if ($Key.Modifiers -band [ConsoleModifiers]::Control) {
                $newState.Status = [PromptStatus]::Cancelled
            }
        }
    }

    return $newState
}