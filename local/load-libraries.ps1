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
  $uri = "http://www.samsonov.net/wp/assets/Dist_" + $libname + "/" + $platform + "-" + $mode + "/" + $fname
  
  echo "Ready to go for " + $uri

  & "IF NOT EXIST " + $libname + " mkdir " +  $libname
  cd $libname

  Invoke-WebRequest -Uri $uri -OutFile $fname
  & "C:\Program Files\7-Zip\7z" x $fname

  cd ..
}

load "zlib"  $platform "release"
load "libpng" $platform "release"

