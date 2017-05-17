import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$domain = "http://www.nurgo-software.com"
$version_url = "$domain/company/news/20-tidytabs"
$download_url = "$domain/pricing/tidytabs"

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
    function global:au_SearchReplace {
      @{
        "tools\chocolateyInstall.ps1" = @{
          "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
          "(^[$]checksum32\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum32)'"
        }
      }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $download_url -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::InternetExplorer) -SessionVariable sess

    $url   = (($download_page.links | ? href -match '\.msi$' | select -First 1 -expand href))

    $download_version = Invoke-WebRequest -Uri $version_url -WebSession $sess
    $version_text = ($download_version.ParsedHtml.getElementsByTagName("h2") | select -First 1).ChildNodes[0].innerText
    $version_text -match "TidyTabs v(.*)$"
    $version = $Matches[1]

    # todo: get release notes automatically

    return @{
        URL32 = ($domain + $url)
        Version = $version
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update -ChecksumFor all -NoCheckUrl
}