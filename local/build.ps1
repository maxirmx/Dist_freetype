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

Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
& "cd" freetype
"1"
& "mkdir" build
"2"
& "C:\Program Files\CMake\bin\cmake" -E chdir build cmake -G "NMake Makefiles" ..
"3"
& "C:\Program Files\CMake\bin\cmake" --build build 