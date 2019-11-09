powershell -ExecutionPolicy Bypass %~dp0\..\load-freetype.ps1  
powershell -ExecutionPolicy Bypass %~dp0\..\load-libraries.ps1 %1
powershell -ExecutionPolicy Bypass %~dp0\build.ps1 %1 
