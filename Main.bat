@echo off
echo Enter AeroAsm file name without .aeroasm:
set /p input=
cls
echo Run program boot\%input%...
timeout 1>nul
cls
call VM.exe %input%
pause