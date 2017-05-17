import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$domain   = 'http://skyfonts.com/'
$url_prefix = 'http://cdn1.skyfonts.com/client/Monotype_SkyFonts_Winx'
$url_suffix = '.exe.zip'

function global:au_SearchReplace {
  @{
	"tools\chocolateyInstall.ps1" = @{
	  "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
	  "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
	  "(^[$]checksum32\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum32)'"
	  "(^[$]checksum64\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum64)'"
	}
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $domain

    $re    = '\.exe\.zip$'
    $the_url = ($download_page.links | ? href -match $re | select -First 1 -expand href)

    $version_text = $($download_page.ParsedHtml.getElementsByTagName("small") | select -First 1 | % innerText)
    $version_text -match "(\d+\.\d+\.\d+\.\d+)"
    $version = $Matches[1]
	
	$url = $url_prefix + "86_" + $version + $url_suffix
	$url64 = $url_prefix + "64_" + $version + $url_suffix
	
	if( $url -ne $the_url ) {
		Write-Warning "scraped download didn't match anticipated download, can't guess 64bit url"
	}
	
	return @{
		URL32 = $url
		URL64 = $url64
		Version = $version
	}
}

update -ChecksumFor all