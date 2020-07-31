param (
#  version: freetype version
#           someting like 2-10-20
   [parameter(Mandatory=$true)][string]$version
)

$fname  = "freetype2-VER-$version" 
$fname1 =  "$fname.tar"
$fname2 =  "$fname1.gz"
$uri    =  "http://git.savannah.gnu.org/cgit/freetype/freetype2.git/snapshot/$fname2"


Invoke-WebRequest -Uri $uri -OutFile $fname2
& "C:\Program Files\7-Zip\7z" -aoa x $fname2 
& "C:\Program Files\7-Zip\7z" -aoa x $fname1 

Remove-Item $fname2
Remove-Item $fname1
Remove-Item pax_global_header

Rename-Item -Path $fname -NewName freetype


