function Update-SelectStateFromKey {
    param([hashtable]$State, [System.ConsoleKeyInfo]$Key, [string[]]$Options)

    $newState = $State.Clone()
    if (-not $newState.ContainsKey('SelectedIndex')) { $newState.SelectedIndex = 0 }

    switch ($Key.Key) {
        'UpArrow' { $newState.SelectedIndex = if ($newState.SelectedIndex -gt 0) { $newState.SelectedIndex - 1 } else { $Options.Count - 1 } }
        'DownArrow' { $newState.SelectedIndex = if ($newState.SelectedIndex -lt ($Options.Count - 1)) { $newState.SelectedIndex + 1 } else { 0 } }
        'Enter' { $newState.Value = $Options[$newState.SelectedIndex]; $newState.Status = [PromptStatus]::Submitted }
        'Escape' { $newState.Status = [PromptStatus]::Cancelled }
    }

    return $newState
}