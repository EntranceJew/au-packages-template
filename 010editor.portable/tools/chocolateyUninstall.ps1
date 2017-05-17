$ErrorActionPreference = 'Stop'

$installLocation = Join-Path $(Get-ToolsLocation) '010editor'

Write-Host "Removing Git from the '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0