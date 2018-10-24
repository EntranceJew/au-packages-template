$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Installer.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Installer.exe'
$checksum32  = '0645e61f4a85b09638e2f13eee403625869b91cc483dc4bb6a929d2b503058df'
$checksum64  = 'a4ce248cc2a2cbe4fb788951008b074dac9df0d7eba981351c87f82480e2a231'

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
