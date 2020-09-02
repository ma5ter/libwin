@rem set DEPENDS_ON=Jpeg-turbo
@call ../build.cmd run "https://github.com/DanBloomberg/leptonica.git" "-DBUILD_PROG=0 -DSW_BUILD=0" "src\leptonica.dir\Debug" %* >build.log
