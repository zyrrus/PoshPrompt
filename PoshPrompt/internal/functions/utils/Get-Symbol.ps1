function Get-Symbol {
    param([hashtable]$State)
    $meta = $Script:PromptStatusMeta[$State.Status.ToString()]
    return Format-AnsiText $meta.Symbol -Foreground $meta.Style.Foreground
}