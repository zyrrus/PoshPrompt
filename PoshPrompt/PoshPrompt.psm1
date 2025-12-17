$public = @( Get-ChildItem -Path $PSScriptRoot\functions\**\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$private = @( Get-ChildItem -Path $PSScriptRoot\internal\**\*.ps1 -Recurse -ErrorAction SilentlyContinue )

foreach ($import in @($public + $private)) {
    try {
        . $import.fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $public.Basename
