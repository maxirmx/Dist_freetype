@echo off
rem --------------------------------------------------------------------
rem Test script to validate some steps of the build procedures locally
rem Usage test.cmd <platform> <configuration>
rem        platform: either 'X64' or 'x86'
rem                  'amd64' is accepted as well and converted to 'X64'
rem                   (load-library) default is 'X64'
rem        configuration: either 'debug' or 'release'
rem                   (load-library) default is 'debug'
rem --------------------------------------------------------------------
@echo on

cd ..

IF NOT EXIST freetype (powershell -ExecutionPolicy Bypass .\load-freetype.ps1 "2-10-2")
IF NOT EXIST zlib     (powershell -ExecutionPolicy Bypass .\EZTools\load-library.ps1 zlib %1 %2)
IF NOT EXIST libpng   (powershell -ExecutionPolicy Bypass .\EZTools\load-library.ps1 libpng %1 %2)

powershell -ExecutionPolicy Bypass .\build.ps1 %1 %2

cd %~dp0
