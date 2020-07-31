Param (
#  version: freetype version
#           someting like 2-10-20
   [parameter(Mandatory=$true)][string]$version,
#  platform: either 'X64' or 'x86'
#            'amd64' is accepted as well and converted to 'X64'
   [parameter(Mandatory=$false)][string]$platform="X64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug"
)


$v = $version.Replace("-",".")

$old_path =   "./freetype/build/freetype-$v-win32.zip"
$new_name =   "freetype-$platform-$configuration.zip"

Rename-Item -Path $old_path -NewName $new_name
