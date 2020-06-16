param (
  [string] $version="2-10-1"
)

$fname  = "freetype2-VER-" + $version 
$fname1 =  $fname  + ".tar"
$fname2 =  $fname1 + ".gz"
$uri    =  "http://git.savannah.gnu.org/cgit/freetype/freetype2.git/snapshot/" + $fname2


Invoke-WebRequest -Uri $uri -OutFile $fname2
& "C:\Program Files\7-Zip\7z" -aoa x $fname2 
del $fname2
del $fname1
del pax_global_header
ren $fname freetype

