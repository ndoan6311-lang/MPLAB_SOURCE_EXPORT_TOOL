@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 90_Bootstrap.bat
::  Purpose     : Framework Bootstrap
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Load Framework Modules
::      • Verify Required Modules
::      • Prevent Duplicate Loading
::      • Prepare Runtime Environment
::
::#######################################################################


::=======================================================================
:: MODULE GUARD
::=======================================================================

if defined BOOTSTRAP_MODULE_LOADED (
    exit /b 0
)

set "BOOTSTRAP_MODULE_LOADED=1"


::=======================================================================
:: LOAD FRAMEWORK MODULES
::=======================================================================

call :Bootstrap_LoadModule "001_Core.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "002_Scan.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "003_Menu.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "004_Search.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "005_Export.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "006_Statistics.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "007_Progress.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "008_Cleanup.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

goto Bootstrap_VerifyModules

::=======================================================================
:: Bootstrap.LoadModule
::-----------------------------------------------------------------------
:: Purpose
::     Load one framework module.
::
:: Input
::     %1 = Module filename
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Bootstrap_LoadModule

if "%~1"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if not exist "%~dp0%~1" (

    set "BOOTSTRAP_ERROR_MODULE=%~1"
    exit /b 1
)

call "%~dp0%~1"

if errorlevel 1 (

    set "BOOTSTRAP_ERROR_MODULE=%~1"
    exit /b 1

)

exit /b 0

::=======================================================================
:: VERIFY REQUIRED MODULES
::=======================================================================

:Bootstrap_VerifyModules

if not defined CORE_MODULE_LOADED goto MissingCore

::-----------------------------------------------------------------------
:: Reserved For Future Verification
::-----------------------------------------------------------------------

if not defined SCAN_MODULE_LOADED       goto MissingScan
if not defined MENU_MODULE_LOADED       goto MissingMenu
if not defined SEARCH_MODULE_LOADED     goto MissingSearch
if not defined EXPORT_MODULE_LOADED     goto MissingExport
if not defined STATISTICS_MODULE_LOADED goto MissingStatistics
if not defined PROGRESS_MODULE_LOADED   goto MissingProgress
if not defined CLEANUP_MODULE_LOADED    goto MissingCleanup

::=======================================================================
:: BOOTSTRAP COMPLETE
::=======================================================================

exit /b 0


::=======================================================================
:: ERROR HANDLER
::=======================================================================

:BootstrapError

echo.

if exist "%~dp001_Core.bat" (

    call "%~dp001_Core.bat" Core.Error
    call "%~dp001_Core.bat" Core.PrintLine

)

echo.
echo Framework initialization failed.
echo.
echo Failed Module:
echo     %BOOTSTRAP_ERROR_MODULE%
echo.
echo The module is missing or failed during initialization.
echo.

if exist "%~dp001_Core.bat" (

    call "%~dp001_Core.bat" Core.PrintLine
    call "%~dp001_Core.bat" Core.Normal

)

exit /b 1


::=======================================================================
:: REQUIRED MODULE MISSING
::=======================================================================

:MissingModule

call "%~dp001_Core.bat" Core.Error
call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Required module not initialized.
echo.
echo     %BOOTSTRAP_ERROR_MODULE%
echo.

call "%~dp001_Core.bat" Core.PrintLine
call "%~dp001_Core.bat" Core.Normal

exit /b 1


::=======================================================================
:: RESERVED ERROR LABELS
::=======================================================================

:MissingCore
set "BOOTSTRAP_ERROR_MODULE=001_Core.bat"
goto MissingModule

:MissingScan
set "BOOTSTRAP_ERROR_MODULE=002_Scan.bat"
goto MissingModule

:MissingMenu
set "BOOTSTRAP_ERROR_MODULE=003_Menu.bat"
goto MissingModule

:MissingSearch
set "BOOTSTRAP_ERROR_MODULE=004_Search.bat"
goto MissingModule

:MissingExport
set "BOOTSTRAP_ERROR_MODULE=005_Export.bat"
goto MissingModule

:MissingStatistics
set "BOOTSTRAP_ERROR_MODULE=006_Statistics.bat"
goto MissingModule

:MissingProgress
set "BOOTSTRAP_ERROR_MODULE=007_Progress.bat"
goto MissingModule

:MissingCleanup
set "BOOTSTRAP_ERROR_MODULE=008_Cleanup.bat"
goto MissingModule