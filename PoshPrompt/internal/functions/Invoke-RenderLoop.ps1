function Invoke-RenderLoop {
    param(
        [hashtable]$InitialState,
        [scriptblock]$RenderFunction,
        [scriptblock]$UpdateFunction
    )

    $state = $InitialState
    [Console]::CursorVisible = $false
    $prevLineCount = 0

    try {
        while ($true) {
            $output = & $RenderFunction $state
            $lines = $output -split "`n"

            $clearLines = Clear-Lines -LineCount $prevLineCount
            Write-Host "$clearLines$($lines -join "`n")"

            if (($state.Status -eq [PromptStatus]::Submitted) -or ($state.Status -eq [PromptStatus]::Cancelled)) {
                break
            }

            $key = [Console]::ReadKey($true)
            $state = & $UpdateFunction $state $key

            $prevLineCount = $lines.Count
        }

        return $state
    }
    finally {
        [Console]::CursorVisible = $true
    }
}