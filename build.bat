@echo off
setlocal EnableExtensions EnableDelayedExpansion

title MPLAB SOURCE EXPORT TOOL

call "%~dp0modules\99_Main.bat"

set "EXIT_CODE=%ERRORLEVEL%"

endlocal & exit /b %EXIT_CODE%