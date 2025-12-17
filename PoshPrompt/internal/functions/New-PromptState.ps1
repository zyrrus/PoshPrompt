enum PromptStatus {
    Default
    Submitted
    Cancelled
    Error
}

function New-PromptState {
    param(
        [string]$Value = "",
        [int]$CursorPosition = 0,
        [PromptStatus]$Status = [PromptStatus]::Default,
        [string]$Feedback = ""
    )
    return @{
        Value          = $Value
        CursorPosition = $CursorPosition
        Status         = $Status
        Feedback       = $Feedback
    }
}