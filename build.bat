@echo off
setlocal EnableExtensions EnableDelayedExpansion

title MPLAB SOURCE EXPORT TOOL v3.0

echo.
echo ===============================================
echo        MPLAB SOURCE EXPORT TOOL v3.0
echo ===============================================
echo.

call modules\01_Core.inc

call modules\02_Scan.inc

echo.
echo ===============================================
echo              PROGRAM FINISHED
echo ===============================================
echo.

pause