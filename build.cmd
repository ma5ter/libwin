@echo on
set MY_ARCH=64
set MY_GENERATOR="Visual Studio 15 2017 Win%MY_ARCH%"

chcp 65001>nul
rem call :log PARAMS: %*

if [%1] == [] (
	call :err use as `build.bat function [parameters]`
)

call :%*
exit /b %errorlevel%

rem === RUN ===
:run
if [%1] == [] (
	call :err No git URL was passed as a first parameter
)
set MY_GIT_URL="%~1"
set MY_SRC_DIR="%~n1"
shift
set MY_BUILD_EXTRA=%~1
shift
set MY_PDB_DIR=%~1
shift

call :log Building %MY_SRC_DIR%

:paremeters_parse_begin
if [%1] == [] (
	goto :paremeters_parse_end
) else if [%1]==[keep] (
	call :log Requested to keep the "build" folder after build
	set MY_KEEP=YES
) else if [%1]==[nodebug] (
	call :log Requested to skip building Debug
	set MY_NODEBUG=YES
) else if [%1]==[norelease] (
	call :log Requested to skip building Release
	set MY_NORELEASE=YES
) else if [%1]==[keep] (
	call :log Requested keeping of the "build" folder after build
	set MY_KEEP=YES
) else if [%1]==[clean] (
	call :log Requested clean build
	call :rmrf build
) else if [%1] == [update] (
	call :log Requested an update from %MY_GIT_URL%
	if exist %MY_SRC_DIR% (
		call :exe cd %MY_SRC_DIR%
		call :exe git pull
		call :exe git checkout master
		call :exe cd ..
	) else (
		git clone --depth 1 %MY_GIT_URL%
	)
) else (
	call :err unknown run option '%~1'
)
shift
goto paremeters_parse_begin
:paremeters_parse_end

if not [%DEPENDS_ON%] == [] (
	setlocal enabledelayedexpansion
	for %%x in (%DEPENDS_ON%) do (
		call :log Depends on "%%x"
		set MY_PREFIX=!MY_PREFIX!../../%%x/install;
	)
	if not [!MY_PREFIX!] == [] (
		set MY_BUILD_PREFIX=-DCMAKE_PREFIX_PATH="!MY_PREFIX!"
	)
	setlocal disabledelayedexpansion
)

call :rmrf install.old
if exist install (
	call :log Backing up "install" folder as "install.old"
	call :exe move install install.old 1>nul 2>&1
)

if not exist build (
	call :log This is a CLEAN build
	call :exe mkdir build
)

call :exe cd build
call :log Configuring ...

rem Single/Multi-configuration (-DCMAKE_BUILD_TYPE=Debug): https://stackoverflow.com/questions/24460486/cmake-build-type-is-not-being-used-in-cmakelists-txt#24470998
rem try using -DCMAKE_FIND_LIBRARY_CUSTOM_LIB_SUFFIX=%MY_ARCH% -DCMAKE_INSTALL_LIBDIR=lib%MY_ARCH% 
call :exe cmake -G %MY_GENERATOR% -DCMAKE_INSTALL_PREFIX=../install ^
-DCMAKE_CONFIGURATION_TYPES="Debug;Release" %MY_BUILD_PREFIX% %MY_BUILD_EXTRA% ^
../%MY_SRC_DIR%

if not [%MY_NODEBUG%] == [YES] (
	call :log Building Debug ...
	call :exe cmake --build ./ --config Debug
	call :log Installing Debug ...
	call :exe cmake --install ./ --config Debug
	if exist ..\install\lib (
		call :log Creating "lib" junction ...
		call :exe mklink /J ..\install\lib%MY_ARCH% ..\install\lib
	)
	if exist ..\install\staticlib (
		call :log Creating "staticlib" junction ...
		call :exe mklink /J ..\install\lib%MY_ARCH% ..\install\lib
	)
	if not [%MY_PDB_DIR%] == [] (
		call :log Copying debug information ...
		call :exe copy "%MY_PDB_DIR%\*.pdb" ..\install\lib%MY_ARCH%\
	)
)

setlocal
for /f "tokens=*" %%a in ('cmd /c "dir ..\install\lib%MY_ARCH%\*.lib /A-D /B|findstr /v /r d\.lib$"') do (
	call :log Renaming debug library with non debug name ...
	call :exe move ..\install\lib%MY_ARCH%\%%a ..\install\lib%MY_ARCH%\%%~na%d.lib
)
endlocal

if not [%MY_NORELEASE%] == [YES] (
	call :log Building Release ...
	call :exe cmake --build ./ --config Release
	call :log Installing Release ...
	call :exe cmake --install ./ --config Release
)

call :exe cd ..

if not [%MY_KEEP%] == [YES] (
	call :log Cleaning "build" folder ...
	call :rmrf build
)

call :log Generating library lists ...
call :exe cmd /c "dir install\lib%MY_ARCH%\*.lib /A-D /B|findstr /r d\.lib$ >libd.lst"
call :exe cmd /c "dir install\lib%MY_ARCH%\*.lib /A-D /B|findstr /v /r d\.lib$ >lib.lst"

call :log BUILD DONE!
exit /b 0

:log
echo %*>&2
exit /b 0

:err
call :log ERROR: %*
rem return immediately
exit

:exe
call :log Executing '%*' ...
%*
if not %errorlevel% == 0 (
	call :err #%errorlevel% Executing `%*` failed
)
exit /b 0

:rmrf
if exist %~1 (
	del /s /q "%1">nul
	rd /s /q "%1">nul
	rem The del command does not set the ErrorLevel as long as the given arguments are valid
	if exist "%1" (
		call :err Unable to remove "%1"
	)
)
exit /b 0


