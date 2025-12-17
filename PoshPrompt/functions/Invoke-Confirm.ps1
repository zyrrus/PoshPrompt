function Invoke-Confirm {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Message,
        [bool]$Default = $true
    )

    $initialState = New-PromptState -Value $(if ($Default) { 'y' } else { 'n' })

    $renderFn = { param($s) Render-ConfirmPrompt -State $s -Message $Message -DefaultValue $Default }
    $updateFn = { param($s, $k) Update-ConfirmStateFromKey -State $s -Key $k }

    $finalState = Invoke-RenderLoop -InitialState $initialState -RenderFunction $renderFn -UpdateFunction $updateFn
    if ($finalState.Status -eq [PromptStatus]::Cancelled) { throw "Operation cancelled by user" }
    return ($finalState.Value -eq 'y')
}