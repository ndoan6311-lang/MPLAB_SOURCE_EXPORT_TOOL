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

::-----------------------------------------------------------------------
:: Cleanup Statistics
::-----------------------------------------------------------------------

set /A CLEANUP_DATABASE_COUNT=0

set /A CLEANUP_TEMP_FILE_COUNT=0

set /A CLEANUP_LOG_COUNT=0

set "CLEANUP_GET_DATABASES="

set "CLEANUP_GET_TEMP_FILES="

set "CLEANUP_GET_LOGS="

::=======================================================================
:: API DISPATCHER
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

::-----------------------------------------------------------------------
:: Controller API
::-----------------------------------------------------------------------

if /I "%~1"=="Cleanup.Start"                goto Cleanup_Start
if /I "%~1"=="Cleanup.Finalize"             goto Cleanup_Finalize

::-----------------------------------------------------------------------
:: Runtime API
::-----------------------------------------------------------------------

if /I "%~1"=="Cleanup.Initialize"           goto Cleanup_Initialize

::-----------------------------------------------------------------------
:: Cleanup Services
::-----------------------------------------------------------------------

if /I "%~1"=="Cleanup.DeleteDatabase"       goto Cleanup_DeleteDatabase
if /I "%~1"=="Cleanup.DeleteTemporaryFiles" goto Cleanup_DeleteTemporaryFiles
if /I "%~1"=="Cleanup.DeleteLogs"           goto Cleanup_DeleteLogs

::-----------------------------------------------------------------------
:: Query API
::-----------------------------------------------------------------------

if /I "%~1"=="Cleanup.GetSummary"           goto Cleanup_GetSummary
if /I "%~1"=="Cleanup.GetDatabaseCount"     goto Cleanup_GetDatabaseCount
if /I "%~1"=="Cleanup.GetTempCount"         goto Cleanup_GetTempCount
if /I "%~1"=="Cleanup.GetLogCount"          goto Cleanup_GetLogCount

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
:: Cleanup.Initialize
::-----------------------------------------------------------------------
:: Purpose
::     Initialize cleanup runtime.
::
:: Responsibilities
::     • Prepare cleanup session
::     • Reset cleanup runtime variables
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Cleanup_Initialize

rem Reserved for future runtime initialization.

exit /b %RC_SUCCESS%

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

call "%~f0" Cleanup.Initialize

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

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

call "%~f0" Cleanup.Finalize

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%

::=======================================================================
:: Cleanup.Finalize
::-----------------------------------------------------------------------
:: Purpose
::     Finalize cleanup workflow.
::
:: Responsibilities
::     • Finalize cleanup session
::     • Reserved for future cleanup summary
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Cleanup_Finalize

rem Reserved for future cleanup summary.

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

    set /A CLEANUP_DATABASE_COUNT+=1

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








:Cleanup_GetSummary

call "%~f0" Cleanup.GetDatabaseCount

if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Cleanup.GetTempCount

if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Cleanup.GetLogCount

if errorlevel 1 exit /b %ERRORLEVEL%

exit /b %RC_SUCCESS%












:Cleanup_GetDatabaseCount

set "CLEANUP_GET_DATABASES=%CLEANUP_DATABASE_COUNT%"

exit /b %RC_SUCCESS%















:Cleanup_GetTempCount

set "CLEANUP_GET_TEMP_FILES=%CLEANUP_TEMP_FILE_COUNT%"

exit /b %RC_SUCCESS%












:Cleanup_GetLogCount

set "CLEANUP_GET_LOGS=%CLEANUP_LOG_COUNT%"

exit /b %RC_SUCCESS%















