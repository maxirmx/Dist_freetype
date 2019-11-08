param (
  [string]$platform="amd64"
)

# Invokes a Cmd.exe shell script and updates the environment.
function Invoke-CmdScript {
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
   default { "Platform was not recognized @ 'build.ps1' : " + $platform; exit (-1);  } 
}

$dname = "build"

Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
cd freetype
New-Item -ItemType Directory -Force -Path $dname

& "C:\Program Files\CMake\bin\cmake" -E chdir $dname cmake -G "NMake Makefiles" ..
& "C:\Program Files\CMake\bin\cmake" --build $dname 