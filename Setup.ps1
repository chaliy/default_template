param ( 
    [Parameter(Position = 0, Mandatory=$true)] 
    [string] $InlineSitemap,

    [Parameter(Position = 1, Mandatory=$true)]
    [string] $ProjectTitle
)

# Rename folders and files
gci -r | ?{ $_.Name -like "InlineSitemap*" } | sort Length -desc | % { "Rename:$_"; Rename-Item $_ -NewName ($_.Name.Replace("InlineSitemap", $InlineSitemap)) }

# Rename in files
gci -r -file -ex *.exe | ?{ (gc $_ -raw) -like "*InlineSitemap*" } | % { "Replace:$_"; sc $_ ((gc $_ -raw).Replace("InlineSitemap", $InlineSitemap)) }

gci -r -file -ex *.exe | ?{ (gc $_ -raw) -like "*Inline Sitemap*" } | % { "Replace:$_"; sc $_ ((gc $_ -raw).Replace("Inline Sitemap", $ProjectTitle)) }

