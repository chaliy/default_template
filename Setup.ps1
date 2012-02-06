param ( 
    [Parameter(Position = 0, Mandatory=$true)] 
    [string] $ProjectName,

    [Parameter(Position = 1, Mandatory=$true)]
    [string] $ProjectTitle,
)

# Rename folders and files
gci -r | ?{ $_.Name -like "ProjectName*" } | sort Length -desc | % { "Rename:$_"; Rename-Item $_ -NewName ($_.Name.Replace("ProjectName", $ProjectName)) }

# Rename in files
gci -r -file | ?{ (gc $_ -raw) -like "*ProjectName*" } | % { "Fix:$_"; sc $_ ((gc $_ -raw).Replace("ProjectName", "$ProjectName)) }

# Rename in files
gci -r -file | ?{ (gc $_ -raw) -like "*Project Name*" } | % { "Fix:$_"; sc $_ ((gc $_ -raw).Replace("Project Name", $ProjectTitle)) }