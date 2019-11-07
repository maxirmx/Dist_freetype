"C:\Program Files\CMake\bin\cmake" -E make_directory build
"C:\Program Files\CMake\bin\cmake" -E chdir build cmake -D CMAKE_C_COMPILER="C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/cl.exe" -G "NMake Makefiles" ..
"C:\Program Files\CMake\bin\cmake" --build build