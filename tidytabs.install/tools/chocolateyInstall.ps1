$ErrorActionPreference = 'Stop';

$url32       = 'http://www.nurgo-software.com/download/TidyTabs.msi'
$checksum32  = '38000af988658be544b2d678042d944fa2c884470d6fc14adb48edcc59b3a756'

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
