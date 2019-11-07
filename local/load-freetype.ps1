Invoke-WebRequest -Uri http://git.savannah.gnu.org/cgit/freetype/freetype2.git/snapshot/freetype2-VER-2-10-1.tar.gz -OutFile freetype2-VER-2-10-1.tar.gz
& "C:\Program Files\7-Zip\7z" x freetype2-VER-2-10-1.tar.gz 
& "C:\Program Files\7-Zip\7z" x freetype2-VER-2-10-1.tar 
ren freetype2-VER-2-10-1 freetype
cd freetype
