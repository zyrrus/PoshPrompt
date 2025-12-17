function Invoke-RenderLoop {
    param(
        [hashtable]$InitialState,
        [scriptblock]$RenderFunction,
        [scriptblock]$UpdateFunction
    )

    $state = $InitialState
    [Console]::CursorVisible = $false

    try {
        while ($true) {
            $output = & $RenderFunction $state
            $lines = $output -split "`n"

            foreach ($line in $lines) {
                Write-Host $line
            }

            if (($state.Status -eq [PromptStatus]::Submitted) -or ($state.Status -eq [PromptStatus]::Cancelled)) {
                break
            }

            $key = [Console]::ReadKey($true)
            $state = & $UpdateFunction $state $key

            Clear-Lines -LineCount $lines.Count
        }

        return $state
    }
    finally {
        [Console]::CursorVisible = $true
    }
}