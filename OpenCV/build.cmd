@call ../build.cmd run "https://github.com/opencv/opencv.git" "-DBUILD_SHARED_LIBS=1 -DOPENCV_INSTALL_BINARIES_PREFIX=./ -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -DWITH_GSTREAMER=OFF -DWITH_MSMF=OFF -DVIDEOIO_ENABLE_PLUGINS=OFF -DWITH_FFMPEG=ON -DVIDEOIO_PLUGIN_LIST=ffmpeg -DINSTALL_PYTHON_EXAMPLES=OFF -DBUILD_opencv_python_bindings_generator=0 -DBUILD_opencv_python_tests=0 -DBUILD_JAVA=0 -DENABLE_CXX11=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF" "bin\Debug" %* >build.log
