$ErrorActionPreference = 'Stop';

$url32       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx86_5.9.5.3.exe.zip'
$url64       = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx64_5.9.5.3.exe.zip'
$checksum32  = 'a540bef469ffe6729ecf8e6c47559fbed9b6493fcff43282c6e0fd8b1570beb5'
$checksum64  = 'bcc320dc207d4e883ba3e02b90e589cc2b721378890741bf083bf253b94d6151'

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
