@echo off
setlocal EnableDelayedExpansion

::=======================================================================
:: MPLAB SOURCE EXPORT TOOL
:: Build Entry
::=======================================================================



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

title MPLAB SOURCE EXPORT TOOL

::=======================================================================
:: Start Application
::=======================================================================

call "%~dp0modules\99_Main.bat"

:: Preserve application exit code across ENDLOCAL

set "EXIT_CODE=%ERRORLEVEL%"

endlocal & exit /b %EXIT_CODE%