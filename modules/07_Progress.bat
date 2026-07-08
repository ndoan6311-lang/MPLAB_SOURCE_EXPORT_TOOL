:: Part 1 07_Progress.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 07_Progress.bat
::  Purpose     : Progress Management
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Progress Runtime
::      • Progress Display
::      • Progress Percentage
::      • Progress Controller
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined PROGRESS_MODULE_LOADED (
    set "PROGRESS_MODULE_LOADED=1"
)


::=======================================================================
:: PROGRESS RUNTIME
::=======================================================================

set /A PROGRESS_TOTAL=0
set /A PROGRESS_CURRENT=0
set /A PROGRESS_PERCENT=0

set "PROGRESS_MESSAGE="


::=======================================================================
:: API DISPATCHER
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

if /I "%~1"=="Progress.Initialize" goto Progress_Initialize
if /I "%~1"=="Progress.Start"      goto Progress_Start
if /I "%~1"=="Progress.Update"     goto Progress_Update
if /I "%~1"=="Progress.Percent"    goto Progress_Percent
if /I "%~1"=="Progress.Print"      goto Progress_Print
if /I "%~1"=="Progress.Finish"     goto Progress_Finish

call "%~dp001_Core.bat" Core.Error

echo.
echo Unknown Progress API:
echo     %~1
echo.

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 07_Progress.bat

::#######################################################################
:: INITIALIZATION API
::#######################################################################

:Progress_Initialize

set /A PROGRESS_TOTAL=0
set /A PROGRESS_CURRENT=0
set /A PROGRESS_PERCENT=0

set "PROGRESS_MESSAGE="

exit /b %RC_SUCCESS%



:Progress_Start

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

call "%~f0" Progress.Initialize

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set /A PROGRESS_TOTAL=%~2

exit /b %RC_SUCCESS%

:: Part 3 07_Progress.bat

::#######################################################################
:: UPDATE API
::#######################################################################

:Progress_Update

set /A PROGRESS_CURRENT+=1

exit /b %RC_SUCCESS%

:: Part 4 07_Progress.bat

::#######################################################################
:: DISPLAY API
::#######################################################################

:Progress_Percent

if %PROGRESS_TOTAL% EQU 0 (
    set /A PROGRESS_PERCENT=0
    exit /b %RC_SUCCESS%
)

set /A PROGRESS_PERCENT=PROGRESS_CURRENT*100/PROGRESS_TOTAL

exit /b %RC_SUCCESS%



:Progress_Print

<nul set /P "=Progress : "

<nul set /P "=%PROGRESS_CURRENT%"

<nul set /P "=/"

<nul set /P "=%PROGRESS_TOTAL%"

<nul set /P "= ("

echo %PROGRESS_PERCENT%%%

exit /b %RC_SUCCESS%

:: Part 5 07_Progress.bat

::#######################################################################
:: FINISH API
::#######################################################################

:Progress_Finish

exit /b %RC_SUCCESS%



::#######################################################################
:: END OF FILE
::#######################################################################