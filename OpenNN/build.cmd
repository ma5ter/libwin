@call ../build.cmd run "https://github.com/Artelnics/opennn.git" "-DOpenNN_BUILD_EXAMPLES=0" "opennn\Debug" %* >build.log
copy "build\opennn\Debug\opennn.lib" install\lib64\opennnd.lib
copy "build\opennn\Release\opennn.lib" install\lib64\opennn.lib