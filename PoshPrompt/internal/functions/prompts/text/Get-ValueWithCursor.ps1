function Get-ValueWithCursor {
    param([hashtable]$State)

    $value = $State.Value
    $pos = [math]::Max(0, [math]::Min($State.CursorPosition, $value.Length))

    if ($value.Length -eq 0) {
        # Show a single inverse space as cursor
        return Format-AnsiText ' ' -Style 'Inverse'
    }

    if ($pos -ge $value.Length) {
        $before = $value
        $cursor = ' '
        $after = ''
    }
    else {
        $before = $value.Substring(0, $pos)
        $cursor = $value[$pos]
        $after = if ($pos + 1 -le $value.Length - 1) { $value.Substring($pos + 1) } else { '' }
    }

    return "$before$(Format-AnsiText $cursor -Style 'Inverse')$after"
}