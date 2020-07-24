@echo off
if [%BUILD_WITH_GSTREAMER%] == [YES] (
	set MY_GS_DIR=../../GStreamer/install
	set MY_GS_EXTRA=-DWITH_GSTREAMER=ON -DGSTREAMER_gst_INCLUDE_DIR=%MY_GS_DIR%/include/gstreamer-1.0 -DGSTREAMER_app_LIBRARY=%MY_GS_DIR%/lib/gstapp-1.0.lib -DGSTREAMER_glib_LIBRARY=%MY_GS_DIR%/lib/glib-2.0.lib -DGSTREAMER_glib_INCLUDE_DIR=%MY_GS_DIR%/include/glib-2.0 -DGSTREAMER_base_LIBRARY=%MY_GS_DIR%/lib/gstbase-1.0.lib -DGSTREAMER_gobject_LIBRARY=%MY_GS_DIR%/lib/gobject-2.0.lib -DGSTREAMER_gstreamer_LIBRARY=%MY_GS_DIR%/lib/gstreamer-1.0.lib -DGSTREAMER_glibconfig_INCLUDE_DIR=%MY_GS_DIR%/lib/glib-2.0/include -DGSTREAMER_pbutils_LIBRARY=%MY_GS_DIR%/lib/gstpbutils-1.0.lib -DGSTREAMER_riff_LIBRARY=%MY_GS_DIR%/lib/gstriff-1.0.lib
) else (
	set MY_GS_EXTRA=-DWITH_GSTREAMER=OFF
)
call ../build.cmd run "https://github.com/opencv/opencv.git" "-DBUILD_SHARED_LIBS=1 -DOPENCV_INSTALL_BINARIES_PREFIX=./ -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules %MY_GS_EXTRA% -DWITH_MSMF=OFF -DWITH_FFMPEG=ON -DINSTALL_PYTHON_EXAMPLES=OFF -DBUILD_opencv_python_bindings_generator=0 -DBUILD_opencv_python_tests=0 -DBUILD_JAVA=0 -DENABLE_CXX11=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF" "bin\Debug" %* >build.log
