@echo off
setlocal EnableExtensions EnableDelayedExpansion

::=======================================================================
:: MPLAB SOURCE EXPORT TOOL
:: Build Entry
::=======================================================================

title MPLAB SOURCE EXPORT TOOL

::=======================================================================
:: Verify Framework
::=======================================================================

if not exist "%~dp0modules\99_Main.bat" (
    echo.
    echo ERROR:
    echo     modules\99_Main.bat not found.
    echo.
    endlocal
    exit /b 1
)

::=======================================================================
:: Start Application
::=======================================================================

call "%~dp0modules\99_Main.bat"

set "EXIT_CODE=%ERRORLEVEL%"

endlocal & exit /b %EXIT_CODE%