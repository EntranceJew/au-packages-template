$ErrorActionPreference = 'Stop';

$url32       = 'http://www.nurgo-software.com/download/TidyTabs.zip'
$checksum32  = '1e90dedb39711e26e05fdb645dfed46c29c6750de6041a367aab769ff17bb457'
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
