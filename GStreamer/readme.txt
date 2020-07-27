GET BINARY
https://gstreamer.freedesktop.org/download/#windows
NOTE: get both "runtime installer" & "development installer"

set VERSION=1.16.2
msiexec /a gstreamer-1.0-devel-msvc-x86_64-%VERSION%.msi /qb TARGETDIR=%TEMP%\devel
msiexec /a gstreamer-1.0-msvc-x86_64-%VERSION%.msi /qb TARGETDIR=%TEMP%\runtime

Merge subfolders x86_x64 into one named install
