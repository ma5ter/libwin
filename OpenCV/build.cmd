@echo off
if not exist opencv_contrib (
	git clone --depth 1 https://github.com/opencv/opencv_contrib.git
)

rem with gstreamer
set MY_GSTREAMER=-DWITH_GSTREAMER=1 -DGSTREAMER_gobject_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/gobject-2.0.lib -DGSTREAMER_gst_INCLUDE_DIR=D:/myProjects/libwin/GStreamer/install/include/gstreamer-1.0 -DGSTREAMER_pbutils_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/gstpbutils-1.0.lib -DGSTREAMER_glib_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/glib-2.0.lib -DGSTREAMER_riff_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/gstriff-1.0.lib -DGSTREAMER_base_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/gstbase-1.0.lib -DGSTREAMER_gstreamer_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/gstreamer-1.0.lib -DGSTREAMER_app_LIBRARY=D:/myProjects/libwin/GStreamer/install/lib/gstapp-1.0.lib -DGSTREAMER_glib_INCLUDE_DIR=D:/myProjects/libwin/GStreamer/install/include/glib-2.0 -DGSTREAMER_glibconfig_INCLUDE_DIR=D:/myProjects/libwin/GStreamer/install/lib/glib-2.0/include 
call ../build.cmd run "https://github.com/opencv/opencv.git" "-DBUILD_SHARED_LIBS=1 -DOPENCV_INSTALL_BINARIES_PREFIX=./ -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules %MY_GSTREAMER% -DWITH_MSMF=OFF -DVIDEOIO_ENABLE_PLUGINS=ON -DWITH_FFMPEG=OFF -DVIDEOIO_PLUGIN_LIST=gstreamer -DINSTALL_PYTHON_EXAMPLES=OFF -DBUILD_opencv_python_bindings_generator=0 -DBUILD_opencv_python_tests=0 -DBUILD_JAVA=0 -DENABLE_CXX11=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF" "bin\Debug" %* >build.log
