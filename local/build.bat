rem "C:\Program Files\7-Zip\7z" x freetype-2.10.1.tar.gz 
rem "C:\Program Files\7-Zip\7z" x freetype-2.10.1.tar 
cd freetype-2.10.1
"C:\Program Files\CMake\bin\cmake" -E make_directory build
"C:\Program Files\CMake\bin\cmake" -E chdir build cmake -G "NMake Makefiles" ..
"C:\Program Files\CMake\bin\cmake" --build build