$ErrorActionPreference = 'Stop';

$url32       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx86_5.9.1.0.exe.zip'
$url64       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx64_5.9.1.0.exe.zip'
$checksum32  = 'c6c93f13b4f2af0872beae41389a4093d6403157b1bb86b2b5094227191cf903'
$checksum64  = '619943cc79cfea24e56674e72a4abc0b953930a3ac0d55dbfa0837316b89009a'

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
