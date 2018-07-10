$ErrorActionPreference = 'Stop';

$url32       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx86_5.9.4.0.exe.zip'
$url64       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx64_5.9.4.0.exe.zip'
$checksum32  = 'cb2b1a9679952cd9bd67a87f93c6a4f4f6fe0b7e8fa3ddde5726a0e9644dfd04'
$checksum64  = '9b29f63c45a918c7f6064ddb84aab8e7420aa5273847e4d4affd5b9c627ff936'

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
