@echo on
chcp 65001

cd pugixml
git pull
git checkout master
cd ..

move install install.old
mkdir build
cd build
cmake  -G "Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX=..\install\ -DBUILD_TESTS=OFF ../pugixml
if not %ERRORLEVEL% == 0 goto :error
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" pugixml.sln /t:Build /p:Configuration=Debug;Platform=x64
if not %ERRORLEVEL% == 0 goto :error
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" /p:Configuration=Debug INSTALL.vcxproj
if not %ERRORLEVEL% == 0 goto :error

move ..\install\lib\pugixml.lib ..\install\lib\pugixmld.lib

"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" pugixml.sln /t:Build /p:Configuration=Release;Platform=x64
if not %ERRORLEVEL% == 0 goto :error
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" /p:Configuration=Release INSTALL.vcxproj
if not %ERRORLEVEL% == 0 goto :error

move ..\install\lib ..\install\lib64

cd ..
del /s /q build
rd /s /q build

exit

:error
echo ERROR!