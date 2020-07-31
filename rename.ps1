Param (
#  version: freetype version
#           someting like 2-10-20
   [parameter(Mandatory=$true)][string]$version
)


$version.Replace("-",".")

$old_path =   "./freetype/build/freetype-$version-win32.zip"

Rename-Item -Path $old_path -NewName "freetype.zip"
