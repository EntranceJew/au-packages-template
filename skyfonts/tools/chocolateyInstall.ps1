$ErrorActionPreference = 'Stop';

$url32       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx86_5.9.5.0.exe.zip'
$url64       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx64_5.9.5.0.exe.zip'
$checksum32  = 'e0334e7ddbc94f750fc3ea99db7f619da043a036fe029cbd2cb1b2cb98808c8f'
$checksum64  = '2a6b0a6fb2541461ba98a2bc2739d03cd01a324393d5b98773692e682dfb7c63'

if((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
	$unzip_file = Split-Path $url64 -leaf
} else {
	$unzip_file = Split-Path $url32 -leaf
}
$unzip_full_path = Join-Path $env:TEMP $unzip_file
$unzipped_file = $unzip_full_path.Replace(".zip", "")
$unzipped_file2 = $unzipped_file.Replace(".exe", ".msi")

$webFileArgs = @{
	PackageName   = 'skyfonts'
	FileFullPath  = $unzip_full_path
	
	checksum      = $checksum32
	checksumType  = 'sha256'
	url           = $url32

	checksum64    = $checksum64
	checksumType64= 'sha256'
	url64bit      = $url64
	ForceDownload = $true
}
Get-ChocolateyWebFile @webFileArgs

Get-ChocolateyUnzip -fileFullPath $unzip_full_path -Destination "$env:TEMP"
Get-ChocolateyUnzip -fileFullPath $unzipped_file -Destination "$env:TEMP"

$packageArgs = @{
	packageName    = 'skyfonts'
	fileType       = 'MSI'
	file           = $unzipped_file2
	softwareName   = 'SkyFonts*'
	silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
	validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
rm $unzipped_file -ea 0 -force
rm $unzipped_file2 -ea 0 -force
rm $unzip_full_path -ea 0 -force
