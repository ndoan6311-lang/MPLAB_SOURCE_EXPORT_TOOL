:: Part 1 08_Cleanup.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 08_Cleanup.bat
::  Purpose     : Cleanup Management
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Cleanup Controller
::      • Temporary File Cleanup
::      • Database Cleanup
::      • Runtime Cleanup
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined CLEANUP_MODULE_LOADED (
    set "CLEANUP_MODULE_LOADED=1"
)


::=======================================================================
:: CLEANUP RUNTIME
::=======================================================================

rem Reserved for future runtime variables.

::=======================================================================
:: API DISPATCHER
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

::-----------------------------------------------------------------------
:: Cleanup Controller
::-----------------------------------------------------------------------

if /I "%~1"=="Cleanup.Start" goto Cleanup_Start

::-----------------------------------------------------------------------
:: Cleanup Services
::-----------------------------------------------------------------------

if /I "%~1"=="Cleanup.DeleteDatabase"       goto Cleanup_DeleteDatabase
if /I "%~1"=="Cleanup.DeleteTemporaryFiles" goto Cleanup_DeleteTemporaryFiles
if /I "%~1"=="Cleanup.DeleteLogs"           goto Cleanup_DeleteLogs

::-----------------------------------------------------------------------
:: Unknown API
::-----------------------------------------------------------------------

call "%~dp001_Core.bat" Core.Error

echo.
echo Unknown Cleanup API:
echo     %~1
echo.

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 08_Cleanup.bat

::#######################################################################
:: CLEANUP CONTROLLER API
::#######################################################################

::=======================================================================
:: Cleanup.Start
::-----------------------------------------------------------------------
:: Purpose
::     Execute cleanup workflow.
::
:: Workflow
::     Delete Database
::          ↓
::     Delete Temporary Files
::          ↓
::     Delete Logs
::
:: Responsibilities
::     • Cleanup temporary database
::     • Cleanup temporary files
::     • Cleanup log files
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Cleanup_Start

call "%~f0" Cleanup.DeleteDatabase

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Cleanup.DeleteTemporaryFiles

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Cleanup.DeleteLogs

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%

:: Part 3 08_Cleanup.bat

::#######################################################################
:: CLEANUP DATABASE API
::#######################################################################

::=======================================================================
:: Cleanup.DeleteDatabase
::-----------------------------------------------------------------------
:: Purpose
::     Delete temporary scan database.
::
:: Responsibilities
::     • Verify database file
::     • Delete scan database
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Cleanup_DeleteDatabase

call "%~dp002_Scan.bat" Scan.GetDatabase

if errorlevel 1 (
    exit /b %RC_SUCCESS%
)

if exist "%SCAN_GET_DATABASE%" (

    del /F /Q "%SCAN_GET_DATABASE%"

)

exit /b %RC_SUCCESS%

:: Part 4 08_Cleanup.bat

::#######################################################################
:: CLEANUP TEMPORARY FILES API
::#######################################################################

::=======================================================================
:: Cleanup.DeleteTemporaryFiles
::-----------------------------------------------------------------------
:: Purpose
::     Delete temporary files created by the application.
::
:: Responsibilities
::     • Delete temporary files
::     • Ignore missing files
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Cleanup_DeleteTemporaryFiles

rem Reserved for future temporary files.

exit /b %RC_SUCCESS%



::#######################################################################
:: CLEANUP LOG FILES API
::#######################################################################

::=======================================================================
:: Cleanup.DeleteLogs
::-----------------------------------------------------------------------
:: Purpose
::     Delete temporary log files.
::
:: Responsibilities
::     • Delete runtime log files
::     • Ignore missing files
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Cleanup_DeleteLogs

rem Reserved for future log files.

exit /b %RC_SUCCESS%
























