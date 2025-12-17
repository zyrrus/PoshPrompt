function Invoke-Select {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Message,
        [Parameter(Mandatory)][string[]]$Options
    )

    $initialState = New-PromptState
    $initialState.SelectedIndex = 0

    $renderFn = { param($s) Render-SelectPrompt -State $s -Message $Message -Options $Options }
    $updateFn = { param($s, $k) Update-SelectStateFromKey -State $s -Key $k -Options $Options }

    $finalState = Invoke-RenderLoop -InitialState $initialState -RenderFunction $renderFn -UpdateFunction $updateFn
    if ($finalState.Status -eq [PromptStatus]::Cancelled) { throw "Operation cancelled by user" }
    return $finalState.Value
}