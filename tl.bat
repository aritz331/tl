@echo off
title TLauncher Downloader ^| by aritz331_ for Aritz's Utils - an aritz331_ original series
rd /s /q %temp%\331 >nul 2>&1
md %temp%\331
pushd %temp%\331

call :update
call :check

set "tl=%userprofile%\.tl"

if not exist %tl% (
	md %tl%
)

attrib -s -h -r %tl%

if not exist %tl%\java\  (call :dl-j )
if not exist %tl%\tl.jar (
	call :dl-7z
	call :dl-tl
)
call :start
exit /b

:update
curl -kLs "https://aritz331.github.io/tl/tl.bat" -o tl2.bat || exit /b
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
curl -kLO "https://aritz331.github.io/stuff/7z/{7z.exe,7-zip.dll}" --progress-bar
curl -kLO "https://aritz331.github.io/stuff/7z/{7z.dll,7-zip32.dll}" --progress-bar
exit /b

:dl-tl
echo Downloading TLauncher
curl -kL "https://tlauncher.org/jar" -o tl.zip --progress-bar
call :7z-tl
exit /b

:dl-j
echo Downloading Java
curl -kL "https://download.oracle.com/java/18/archive/jdk-18.0.1.1_windows-x64_bin.exe" -o java.zip --progress-bar
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
rd /s /q %temp%\331
attrib -s -h -r %tl%
cd %tl%
start java\bin\javaw.exe -jar tl.jar
attrib +s +h +r %tl%
exit /b
