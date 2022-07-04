@echo off
rd /s /q %temp%\331 >nul 2>&1
md %temp%\331
pushd %temp%\331

call :update
popd
call :push
exit /b

:update
curl -kLs "https://aritz331.github.io/tl/tl.bat" -o tl2.bat || exit /b
fc "%~dp0tl.bat" "tl2.bat">nul || (exit /b)
goto exi

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
goto %yn%
exit /b

:psh
git add *
git commit -m "auto push"
git push
exit /b

:exi
exit /b