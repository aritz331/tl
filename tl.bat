@echo off
title TLauncher Downloader ^| by aritz331_ for Aritz's Utils - an aritz331_ original series
if not exist %temp%\331 (md %temp%\331) else (attrib -s -h -r %temp%\331)
cd %temp%\331

call :update
call :check

set "tl=%userprofile%\.tl"

if not exist %tl% (
	md %tl%
)

attrib -s -h -r %tl%


if not exist %tl%\java\  (
	7z >nul 2>&1 || call :dl-7z
	call :dl-j
)
if not exist %tl%\tl.jar (
	7z >nul 2>&1 || call :dl-7z
	call :dl-tl
)
call :start
exit /b

:update
curl -#kL "https://aritz331.github.io/tl/tl.bat" -o tl2.bat || exit /b
fc "%~dpnx0" "tl2.bat">nul || (goto doupdate)
exit /b

:doupdate
popd
start /min "" cmd /c ping localhost -n 2^>nul ^& move "%temp%\331\tl2.bat" "%~dpnx0" ^& start %~dpnx0
exit

:check
echo ok>s1.txt
curl -kLs "https://aritz331.github.io/tl/s.txt" -o s2.txt
fc s1.txt s2.txt>nul || goto not
exit /b

:dl-7z
echo Downloading 7-zip
curl -#kLO "https://aritz331.github.io/stuff/7z/{7z.exe,7-zip.dll}"
curl -#kLO "https://aritz331.github.io/stuff/7z/{7z.dll,7-zip32.dll}"
exit /b

:dl-tl
echo Downloading TLauncher
curl -#kL "https://tlauncher.org/jar" -o tl.zip
call :7z-tl
exit /b

:dl-j
echo Downloading Java
curl -#kL "https://download.oracle.com/java/18/archive/jdk-18.0.1.1_windows-x64_bin.exe" -o java.zip
call :7z-j
exit /b

:7z-tl
7z e -y tl.zip TL*.jar -so > %tl%\tl.jar
exit /b

:7z-j
cls
7z e -y java.zip st.cab -o.
cls
7z e -y st.cab tools.zip -o.
cls
7z x -y tools.zip -o%tl%\java\
cls
exit /b

:start
popd
pushd %tl%
start java\bin\javaw.exe -jar tl.jar
popd
attrib +s +h +r %tl%
attrib +s +h +r %temp%\331
set "tl="
exit /b
