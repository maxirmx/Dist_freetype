param (
  [string] $platform="X64"
)

function load {
  param (
    [string] $libname,
    [string] $platform = "X64",
    [string] $mode = "release"
  )

  $fname = $libname +".7z"
  $dname = $libname
  $uri = "http://www.samsonov.net/wp/assets/Dist_" + $libname + "/" + $platform + "-" + $mode + "/" + $fname
  
  echo "Ready to go for " + $uri

  New-Item -ItemType Directory -Force -Path $dname

  cd $dname

  Invoke-WebRequest -Uri $uri -OutFile $fname
  & "C:\Program Files\7-Zip\7z" -aoa x $fname
  del $fname

  cd ..
}

switch($platform) {
   "X64"   { break; } 
   "x86"   { break; } 
   "amd64" { $platform = "X64"; break; } 
   default { "Platform was not recognized @ 'load-libraries.ps1' : " + $platform; exit (-1);  } 
}

load "zlib"  $platform "release"
load "libpng" $platform "release"

