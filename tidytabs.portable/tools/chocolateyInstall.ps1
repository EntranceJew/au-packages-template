$ErrorActionPreference = 'Stop';

$url32       = 'http://www.nurgo-software.com/download/TidyTabs.zip'
$checksum32  = '12d8f0c24cb909ba78e8bc12e9d397a846d8ea1eb2cea5774bdc4d792bf591bb'
$installLocation = Join-Path "$env:ChocolateyInstall\lib" "tidytabs.portable\tools"

New-Item "$installLocation\TidyTabs.Daemon.exe.gui" -type file -force | Out-Null
New-Item "$installLocation\TidyTabs.Gui.exe.ignore" -type file -force | Out-Null
New-Item "$installLocation\TidyTabs.UipiAgent.exe.ignore" -type file -force | Out-Null
New-Item "$installLocation\TidyTabs.Updater.exe.ignore" -type file -force | Out-Null

$packageArgs = @{
  packageName   = 'tidytabs.portable'
  softwareName  = 'TidyTabs*'
  unzipLocation = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

  checksum      = $checksum32
  checksumType  = 'sha256'
  url           = $url32
}

Install-ChocolateyZipPackage @packageArgs
