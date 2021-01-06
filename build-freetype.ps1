Param (
#  platform: either 'amd64' or 'x86'
#            'X64' is accepted as well and converted to 'amd64'
   [parameter(Mandatory=$false)][string]$platform="amd64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug",
# configure switch implies running vcvarsall.bat through CmdScript to inherit environment variables (local build)
   [parameter()][switch]$configure
)

 switch($platform) {
   "X64"   { $platform = "amd64"; break;  } 
   "x86"   { break; } 
   "amd64" { break; } 
   default { "build-freetype.ps1: platform <" + $platform + "> was not recognized"; exit (-1);  } 
 }

 switch($configuration) {
   "release" { break; } 
   "debug"   { break; } 
   default   { "build-freetype.ps1: configuration <" + $configuration + "> was not recognized"; exit (-1);  } 
 }

 if ($configure) {
  .\EZTools\use-environment.ps1 "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
  $cmake = "C:\Program Files\CMake\bin\cmake" 
 } else {
  $cmake = "cmake"
 }

$dname = Get-Location

Set-Location "freetype"
if (-Not (Test-Path "build")) {
 New-Item -ItemType Directory -Force -Path build
} 
Set-Location "build"

if (Test-Path "CMakeCache.txt") {
  Remove-Item "CMakeCache.txt"
}

$bp1 =  @("-G","""NMake Makefiles""",
		"-D","ZLIB_LIBRARY=../../zlib/lib",
                "-D","ZLIB_INCLUDE_DIR=../../zlib/include", 
                "-D","PNG_LIBRARY=../../libpng/lib",
                "-D","PNG_PNG_INCLUDE_DIR=../../libpng/include",
		"-D","CMAKE_BUILD_TYPE=$configuration",
		"-D","CMAKE_INSTALL_PREFIX=""$dname\d""",
		"-D","DISABLE_FORCE_DEBUG_POSTFIX=true",
                "-D","CPACK_INCLUDE_TOPLEVEL_DIRECTORY=false", 
                "..")

# Manually packaged in .appveyor.yml script
# $bp2 =  @("--build",  ".",
#           "--target", "package")

$bp2 =  @("--build",  ".",
          "--target", "install")

& $cmake  $bp1
& $cmake  $bp2

Set-Location $dname
