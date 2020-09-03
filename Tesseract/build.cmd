@set BRANCH=4.1
@set DEPENDS_ON=Leptonica
@call ../build.cmd run "https://github.com/tesseract-ocr/tesseract.git" "-DBUILD_TESTS=OFF -DGRAPHICS_DISABLED=0 -DBUILD_TRAINING_TOOLS=1 -DENABLE_LTO=0 -DDISABLED_LEGACY_ENGINE=0 -DUSE_SYSTEM_ICU=1 -DSW_BUILD=0" "bin\Debug" %* >build.log
