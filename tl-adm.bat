rem @echo off
rd /s /q %temp%\331 >nul 2>&1
md %temp%\331
pushd %temp%\331

call :update
exit /b

:update
for /f %%i in ('dir /b /a-D %~dp0') do (
	curl -kLs "https://aritz331.github.io/tl/%%i" -o %%i2 || exit /b
	fc "%~dp0%%i" "%%i2" || (popd&goto push)
)
goto :EOF
exit /b

:push
for /f "tokens=* delims=:" %%i in ('type %temp%\t') do (
	set "i=%%i"
	set /a "it=%i%+30"
	if "%time:~6,2%" LSS "%it%" (
		set "j=%%j"
		set /a "jt=%j%+30"
		if "%time:~3,2%" LSS "%jt%" (
			set "can=no"
		) 

	)
)
set /a "wt=%t%-%j%:%t%-%i%"
if "can"=="no" (echo Please wait %wt%&exit/b)

echo Do you want to push?
echo :=^> y
echo =:^> n
echo.
choice /c "yBUn" /n /m "> "
set /a "el=%errorlevel%-1"
set "yn=pshexi"
setlocal enabledelayedexpansion
set "yn=!yn:~%el%,3!"
cls
goto %yn%
exit /b

:psh
git add *
git commit -m "auto push"
git push
ping localhost -n 3 >nul
echo %time:~6,2%>%temp%\t
echo %time:~3,2%>>%temp%\t
exit /b

:exi
exit /b