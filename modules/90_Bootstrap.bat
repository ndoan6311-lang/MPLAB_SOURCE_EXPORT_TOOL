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




::=======================================================================
:: LOAD FRAMEWORK MODULES
::=======================================================================

call :Bootstrap_LoadModule "01_Core.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "02_Scan.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "03_Menu.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "04_Search.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "05_Export.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "06_Statistics.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "07_Progress.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

call :Bootstrap_LoadModule "08_Cleanup.bat"
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

    echo.
    echo ==========================================
    echo MODULE NOT FOUND
    echo %~dp0%~1
    echo ==========================================
    pause

    set "BOOTSTRAP_ERROR_MODULE=%~1"
    exit /b 1
)

echo Loading %~1 ...

call "%~dp0%~1"

echo Return=%ERRORLEVEL%

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=%~1"
    call :BootstrapError
    exit /b %ERRORLEVEL%
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

set "BOOTSTRAP_MODULE_LOADED=1"

exit /b 0


::=======================================================================
:: ERROR HANDLER
::=======================================================================

:BootstrapError

call "%~dp001_Core.bat" Core.Error

call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Framework initialization failed.
echo.
echo Failed Module:
echo     %BOOTSTRAP_ERROR_MODULE%
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

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
set "BOOTSTRAP_ERROR_MODULE=01_Core.bat"
goto BootstrapError

:MissingScan
set "BOOTSTRAP_ERROR_MODULE=02_Scan.bat"
goto BootstrapError

:MissingMenu
set "BOOTSTRAP_ERROR_MODULE=03_Menu.bat"
goto BootstrapError

:MissingSearch
set "BOOTSTRAP_ERROR_MODULE=04_Search.bat"
goto BootstrapError

:MissingExport
set "BOOTSTRAP_ERROR_MODULE=05_Export.bat"
goto BootstrapError

:MissingStatistics
set "BOOTSTRAP_ERROR_MODULE=06_Statistics.bat"
goto BootstrapError

:MissingProgress
set "BOOTSTRAP_ERROR_MODULE=07_Progress.bat"
goto BootstrapError

:MissingCleanup
set "BOOTSTRAP_ERROR_MODULE=08_Cleanup.bat"
goto BootstrapError