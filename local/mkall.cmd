powershell -executionpolicy bypass ../load-freetype.ps1  
powershell -executionpolicy bypass ../load-libraries.ps1 %1
powershell -executionpolicy bypass ./build.ps1 %1 
