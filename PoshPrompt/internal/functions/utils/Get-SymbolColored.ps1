function Get-SymbolColored {
    param([string]$Symbol, [hashtable]$State)
    $meta = $Script:PromptStatusMeta[$State.Status.ToString()]
    if ($State.Status -eq [PromptStatus]::Submitted) {
        return Format-AnsiText $Symbol -Style 'Dim'
    }
    return Format-AnsiText $Symbol -Foreground $meta.Style.Foreground
}