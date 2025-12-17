function Clear-Lines {
    param([int]$LineCount)
    
    if ($LineCount -eq 0) { return }
    
    $esc = [char]0x1b
    
    # Build entire clear sequence as one string
    $clearSequence = "$esc[1A$esc[2K" * $LineCount # Up + Clear line for each line
    $clearSequence += "$esc[0G"  # Move to column 0
    
    return $clearSequence
}