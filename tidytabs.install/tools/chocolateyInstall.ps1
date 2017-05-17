$ErrorActionPreference = 'Stop';

$url32       = 'http://www.nurgo-software.com/download/TidyTabs.msi'
$checksum32  = '58423eccfaecce547934e3a206e6da39e3d9245b6cd17134be766ac7e1c030f1'

$packageArgs = @{
  packageName   = 'tidytabs.install'
  fileType      = 'MSI'
  softwareName  = 'TidyTabs*'
  
  checksum      = $checksum32
  checksumType  = 'sha256'
  url           = $url32

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
