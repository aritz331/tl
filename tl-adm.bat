@echo off
rd /s /q %temp%\331 >nul 2>&1
md %temp%\331
pushd %temp%\331

call :update
exit /b

:update
echo on
for /f %%i in ('dir /b /a-D %~dp0') do (
	curl -kLs "https://aritz331.github.io/tl/%%i" -o %%i2 || exit /b
	fc "%~dp0%%i" "%%i2" || (popd&goto push)
)
goto :EOF
exit /b

:push
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
exit /b

:exi
exit /b