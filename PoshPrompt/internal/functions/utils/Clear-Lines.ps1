function Clear-Lines {
    param([int]$LineCount)
    
    $currentPos = $Host.UI.RawUI.CursorPosition
    $linesToClear = [Math]::Min($LineCount, $currentPos.Y)
    
    for ($i = 0; $i -lt $linesToClear; $i++) {
        $currentPos.Y--
        $currentPos.X = 0
        $Host.UI.RawUI.CursorPosition = $currentPos
        
        $width = $Host.UI.RawUI.BufferSize.Width
        Write-Host (' ' * $width) -NoNewline
        
        $Host.UI.RawUI.CursorPosition = $currentPos
    }
}