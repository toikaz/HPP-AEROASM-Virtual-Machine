@echo off
echo =======================
echo AEROASM-Virtual-machine
echo =======================
echo build 1.0 Alpha
echo.
echo.
echo Enter AeroAsm file name without .aeroasm:
set /p input=
cls
timeout 1 >nul
echo Run program boot\%input%...
timeout 1 >nul
cls
call VM.exe %input%
pause
