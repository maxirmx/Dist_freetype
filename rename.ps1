Param (
#  version: freetype version
#           someting like 2-10-20
   [parameter(Mandatory=$true)][string]$version
)


$v = $version.Replace("-",".")

$old_path =   "./freetype/build/freetype-$v-win32.zip"

Rename-Item -Path $old_path -NewName "freetype.zip"
