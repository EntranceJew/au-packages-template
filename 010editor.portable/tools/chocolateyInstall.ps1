$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Portable.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Portable.exe'
$checksum32  = '28ba4beecb8e4e5d87c5bd2b4986a25341734956c1bc47034e80241618ee84d7'
$checksum64  = 'ccf8f90615d7de64734aa3e3974e3e9ec40e9092bd84cadbf0b6a139706e2cb4'
$installLocation = Join-Path $(Get-ToolsLocation) '010editor'

$packageArgs = @{
  packageName   = '010editor'
  fileType      = 'EXE'
  softwareName  = '010 Editor*'
  
  checksum      = $checksum32
  checksumType  = 'sha256'
  url           = $url32

  checksum64    = $checksum64
  checksumType64= 'sha256'
  url64bit      = $url64

  silentArgs   = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /DIR=`"$env:ChocolateyToolsLocation`""
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
