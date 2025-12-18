function Invoke-MultiSelect {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Message,
        [Parameter(Mandatory)][string[]]$Options,
        [scriptblock]$Validate = $null
    )

    $initialState = New-PromptState
    $initialState.HoveredIndex = 0
    $initialState.SelectedIndices = [System.Collections.Generic.HashSet[int]]::new()

    $renderFn = { param($s) Render-MultiSelectPrompt -State $s -Message $Message -Options $Options }
    $updateFn = { param($s, $k) Update-MultiSelectStateFromKey -State $s -Key $k -Options $Options -Validate $Validate }

    $finalState = Invoke-RenderLoop -InitialState $initialState -RenderFunction $renderFn -UpdateFunction $updateFn
    if ($finalState.Status -eq [PromptStatus]::Cancelled) { throw "Operation cancelled by user" }
    return $finalState.Value
}