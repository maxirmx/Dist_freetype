Param (
#  platform: either 'amd64' or 'x86'
#            'X64' is accepted as well and converted to 'amd64'
   [parameter(Mandatory=$false)][string]$platform="amd64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug",
# configure switch implies running vcvarsall.bat through CmdScript to inherit environment variables (local build)
   [parameter()][switch]$configure
)

# Invokes a Cmd.exe shell script and updates the environment.
function CmdScript {
  param(
    [string] $scriptName
  )
  $cmdLine = """$scriptName"" $args & set"
  & $Env:SystemRoot\system32\cmd.exe /c $cmdLine |
  select-string '^([^=]*)=(.*)$' | foreach-object {
    $varName = $_.Matches[0].Groups[1].Value
    $varValue = $_.Matches[0].Groups[2].Value
    set-item Env:$varName $varValue
  }
}

 switch($platform) {
   "X64"   { $platform = "amd64"; break;  } 
   "x86"   { break; } 
   "amd64" { break; } 
   default { "build.ps1: platform <" + $platform + "> was not recognized"; exit (-1);  } 
 }

 switch($configuration) {
   "release" { break; } 
   "debug"   { break; } 
   default   { "build.ps1: configuration <" + $configuration + "> was not recognized"; exit (-1);  } 
 }

 $dname = "build"

 if ($configure) {
  CmdScript "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
  $cmake = "C:\Program Files\CMake\bin\cmake" 
 } else {
  $cmake = "cmake"
 }

 cd freetype
 New-Item -ItemType Directory -Force -Path $dname
 cd $dname

 $bp1 =  @("-D","ZLIB_LIBRARY=../../zlib/lib",
                "-D","ZLIB_INCLUDE_DIR=../../zlib/include", 
                "-D","PNG_LIBRARY=../../libpng/lib",
                "-D","PNG_PNG_INCLUDE_DIR=../../libpng/include",
                "-G","""NMake Makefiles""",
		"-D","CMAKE_BUILD_TYPE=$configuration",
                "-D","CPACK_INCLUDE_TOPLEVEL_DIRECTORY=false", 
                "..")

 $bp2 =  @("--build",  ".",
           "--target", "package")

 & $cmake  $bp1
 & $cmake  $bp2

 cd ../.. 
