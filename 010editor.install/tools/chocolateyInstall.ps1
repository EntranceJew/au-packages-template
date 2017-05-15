$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Installer.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Installer.exe'
$checksum32  = 'aae746a027689a0153188f2abf095620fff23513b8620ac270421a7d39161a8f'
$checksum64  = '539f6d901e544a5a80d01112fadf8346fd6b0f07c56c79f9ce676ff180bb26ce'

$packageArgs = @{
  packageName   = '010editor.install'
  fileType      = 'EXE'
  softwareName  = '010 Editor*'
  
  checksum      = $checksum32
  checksumType  = 'sha256'
  url           = $url32

  checksum64    = $checksum64
  checksumType64= 'sha256'
  url64bit      = $url64

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
