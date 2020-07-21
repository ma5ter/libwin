@echo on
chcp 65001

cd opencv
git pull
git checkout master
cd ..

cd opencv_contrib
git pull
git checkout master
cd ..

rem del /s /q build
rem rd /s /q build

mkdir build
cd build
rem note that paths must have "/" notation
cmake  -G "Visual Studio 15 2017 Win64" -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules ^
 -DWITH_GSTREAMER=OFF -DWITH_MSMF=OFF -DVIDEOIO_ENABLE_PLUGINS=OFF -DWITH_FFMPEG=ON -DVIDEOIO_PLUGIN_LIST=ffmpeg ^
 -DINSTALL_PYTHON_EXAMPLES=OFF -DENABLE_CXX11=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF  ../opencv

rem -DGSTREAMER_DIR=../../GStreamer/install/gstreamer/1.0/x86_64 ^
rem -DGSTREAMER_app_LIBRARY=${GSTREAMER_DIR}/lib/gstapp-1.0.lib ^
rem -DGSTREAMER_base_LIBRARY=${GSTREAMER_DIR}/lib/gstbase-1.0.lib ^
rem -DGSTREAMER_glib_INCLUDE_DIR=${GSTREAMER_DIR}/include/glib-2.0 ^
rem -DGSTREAMER_glib_LIBRARY=${GSTREAMER_DIR}/lib/glib-2.0.lib ^
rem -DGSTREAMER_glibconfig_INCLUDE_DIR=${GSTREAMER_DIR}/lib/glib-2.0/include ^
rem -DGSTREAMER_gobject_LIBRARY=${GSTREAMER_DIR}/lib/gobject-2.0.lib ^
rem -DGSTREAMER_gst_INCLUDE_DIR=${GSTREAMER_DIR}/include/gstreamer-1.0 ^
rem -DGSTREAMER_gstreamer_LIBRARY=${GSTREAMER_DIR}/lib/gstreamer-1.0.lib ^
rem -DGSTREAMER_pbutils_LIBRARY=${GSTREAMER_DIR}/lib/gstpbutils-1.0.lib ^
rem -DGSTREAMER_riff_LIBRARY=${GSTREAMER_DIR}/lib/gstriff-1.0.lib ^

if not %ERRORLEVEL% == 0 goto :error
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" OpenCV.sln /t:Build /p:Configuration=Debug;Platform=x64
if not %ERRORLEVEL% == 0 goto :error
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" /p:Configuration=Debug INSTALL.vcxproj
if not %ERRORLEVEL% == 0 goto :error
rem "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" OpenCV.sln /t:Build /p:Configuration=Release;Platform=x64
rem if not %ERRORLEVEL% == 0 goto :error
rem "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\amd64\MSBuild.exe" /p:Configuration=Release INSTALL.vcxproj
rem if not %ERRORLEVEL% == 0 goto :error

move ../install ../install.old
move install ../
cd ..

exit

:error
echo ERROR!