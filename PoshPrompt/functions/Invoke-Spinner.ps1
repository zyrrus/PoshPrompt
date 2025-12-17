function Invoke-Spinner {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$Message, [Parameter(Mandatory)][scriptblock]$ScriptBlock)

    $frames = @('⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏')
    $job = Start-Job -ScriptBlock $ScriptBlock

    [Console]::CursorVisible = $false
    try {
        $i = 0
        while ($job.State -eq 'Running') {
            $frame = $frames[$i % $frames.Count]
            [Console]::SetCursorPosition(0, [Console]::CursorTop)
            Write-Host "$(Format-AnsiText $frame -Foreground 'Magenta')  $Message" -NoNewline
            Start-Sleep -Milliseconds 80
            $i++
        }
        $result = Receive-Job -Job $job
        [Console]::SetCursorPosition(0, [Console]::CursorTop)
        Write-Host "$(Format-AnsiText '◇' -Foreground 'Green') $Message"
        return $result
    }
    finally {
        [Console]::CursorVisible = $true
        if ($job) { Remove-Job -Job $job -Force -ErrorAction SilentlyContinue }
    }
}