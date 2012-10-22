param ( 
    [Parameter(Position = 0, Mandatory=$true)] 
    [string] $ProjectName,

    [Parameter(Position = 1, Mandatory=$true)]
    [string] $ProjectTitle
)

# Rename folders and files
gci -filter "ProjectName*" -recurse -name | sort -desc | % { "Rename:$_"; Rename-Item $_ -NewName ((Split-Path $_ -Leaf).Replace("ProjectName", $ProjectName)) }

# Rename in files
function ReplaceInFiles($Pattern, $Replace){
    gci *.* -recurse -ex *.exe,*.dll,Setup.ps1 | ? {$_ -is [IO.FileInfo]} | % {    
        $path = $_.FullName
        $x = (gc $path)
        if ($x | select-string -pattern $Pattern) {        
            $y = ($x -replace $Pattern, $Replace)    
            sc $path $y
            Write-Host "Replace: $path"
        }
    }

}

ReplaceInFiles "ProjectName", $ProjectName
ReplaceInFiles "Project Name", $ProjectTitle