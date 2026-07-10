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

if /I "%~1"=="Progress.Initialize"  goto Progress_Initialize

::-----------------------------------------------------------------------
:: Controller API
::-----------------------------------------------------------------------

if /I "%~1"=="Progress.Start"       goto Progress_Start
if /I "%~1"=="Progress.Finish"      goto Progress_Finish

::-----------------------------------------------------------------------
:: Update API
::-----------------------------------------------------------------------

if /I "%~1"=="Progress.Update"      goto Progress_Update
if /I "%~1"=="Progress.Percent"     goto Progress_Percent

::-----------------------------------------------------------------------
:: Display API
::-----------------------------------------------------------------------

if /I "%~1"=="Progress.Print"       goto Progress_Print

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

::=======================================================================
:: Progress.Initialize
::-----------------------------------------------------------------------
:: Purpose
::     Initialize progress runtime.
::
:: Responsibilities
::     • Reset progress counters
::     • Clear progress message
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Progress_Initialize

set /A PROGRESS_TOTAL=0
set /A PROGRESS_CURRENT=0
set /A PROGRESS_PERCENT=0

set "PROGRESS_MESSAGE="

exit /b %RC_SUCCESS%

::=======================================================================
:: Progress.Start
::-----------------------------------------------------------------------
:: Purpose
::     Start a new progress session.
::
:: Responsibilities
::     • Reset progress runtime
::     • Initialize total progress count
::
:: Input
::     %2 = Total progress count
::
:: Output
::     PROGRESS_TOTAL
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Progress_Start

if %~2 LEQ 0 (
    exit /b %RC_INVALID_PARAMETER%
)

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

::=======================================================================
:: Progress.Update
::-----------------------------------------------------------------------
:: Purpose
::     Update current progress.
::
:: Responsibilities
::     • Increase current progress
::
:: Output
::     PROGRESS_CURRENT
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Progress_Update

set /A PROGRESS_CURRENT+=1

call "%~f0" Progress.Percent

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%

:: Part 4 07_Progress.bat

::#######################################################################
:: DISPLAY API
::#######################################################################

::=======================================================================
:: Progress.Percent
::-----------------------------------------------------------------------
:: Purpose
::     Calculate current progress percentage.
::
:: Responsibilities
::     • Calculate progress percentage
::
:: Output
::     PROGRESS_PERCENT
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Progress_Percent

if %PROGRESS_TOTAL% EQU 0 (
    set /A PROGRESS_PERCENT=0
    exit /b %RC_SUCCESS%
)

set /A PROGRESS_PERCENT=PROGRESS_CURRENT*100/PROGRESS_TOTAL

exit /b %RC_SUCCESS%

::=======================================================================
:: Progress.Print
::-----------------------------------------------------------------------
:: Purpose
::     Display current progress.
::
:: Responsibilities
::     • Print progress information
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Progress_Print

call "%~f0" Progress.Percent

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

<nul set /P "=Progress : "

<nul set /P "=%PROGRESS_CURRENT%"

<nul set /P "=/"

<nul set /P "=%PROGRESS_TOTAL%"

<nul set /P "= ("

<nul set /P "=%PROGRESS_PERCENT%"

echo %%)

exit /b %RC_SUCCESS%

:: Part 5 07_Progress.bat

::#######################################################################
:: FINISH API
::#######################################################################

::=======================================================================
:: Progress.Finish
::-----------------------------------------------------------------------
:: Purpose
::     Finish current progress session.
::
:: Responsibilities
::     • Finalize progress display
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Progress_Finish

echo.

exit /b %RC_SUCCESS%



::#######################################################################
:: END OF FILE
::#######################################################################