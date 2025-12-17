function Invoke-Text {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Message,
        [string]$Placeholder = "",
        [scriptblock]$Validate
    )

    $initialState = New-PromptState

    $renderFn = { param($s) Render-TextPrompt -State $s -Message $Message -Placeholder $Placeholder }
    $updateFn = { param($s, $k) Update-TextStateFromKey -State $s -Key $k -Validate $Validate }

    $finalState = Invoke-RenderLoop -InitialState $initialState -RenderFunction $renderFn -UpdateFunction $updateFn

    if ($finalState.Status -eq [PromptStatus]::Cancelled) { throw "Operation cancelled by user" }
    return $finalState.Value
}