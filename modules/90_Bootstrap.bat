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

if not exist "%~dp001_Core.bat" (
    set "BOOTSTRAP_ERROR_MODULE=001_Core.bat"
    goto BootstrapError
)

call "%~dp001_Core.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=001_Core.bat"
    goto BootstrapError
)

if not exist "%~dp002_Scan.bat" (
    set "BOOTSTRAP_ERROR_MODULE=002_Scan.bat"
    goto BootstrapError
)

call "%~dp002_Scan.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=002_Scan.bat"
    goto BootstrapError
)

if not exist "%~dp003_Menu.bat" (
    set "BOOTSTRAP_ERROR_MODULE=003_Menu.bat"
    goto BootstrapError
)

call "%~dp003_Menu.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=003_Menu.bat"
    goto BootstrapError
)

if not exist "%~dp004_Search.bat" (
    set "BOOTSTRAP_ERROR_MODULE=004_Search.bat"
    goto BootstrapError
)

call "%~dp004_Search.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=004_Search.bat"
    goto BootstrapError
)

if not exist "%~dp005_Export.bat" (
    set "BOOTSTRAP_ERROR_MODULE=005_Export.bat"
    goto BootstrapError
)

call "%~dp005_Export.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=005_Export.bat"
    goto BootstrapError
)

if not exist "%~dp006_Statistics.bat" (
    set "BOOTSTRAP_ERROR_MODULE=006_Statistics.bat"
    goto BootstrapError
)

call "%~dp006_Statistics.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=006_Statistics.bat"
    goto BootstrapError
)

if not exist "%~dp007_Progress.bat" (
    set "BOOTSTRAP_ERROR_MODULE=007_Progress.bat"
    goto BootstrapError
)

call "%~dp007_Progress.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=007_Progress.bat"
    goto BootstrapError
)

if not exist "%~dp008_Cleanup.bat" (
    set "BOOTSTRAP_ERROR_MODULE=008_Cleanup.bat"
    goto BootstrapError
)

call "%~dp008_Cleanup.bat"

if errorlevel 1 (
    set "BOOTSTRAP_ERROR_MODULE=008_Cleanup.bat"
    goto BootstrapError
)


::=======================================================================
:: VERIFY REQUIRED MODULES
::=======================================================================

if not defined CORE_MODULE_LOADED goto MissingCore

::-----------------------------------------------------------------------
:: Reserved For Future Verification
::-----------------------------------------------------------------------

:: if not defined SCAN_MODULE_LOADED       goto MissingScan
:: if not defined MENU_MODULE_LOADED       goto MissingMenu
:: if not defined SEARCH_MODULE_LOADED     goto MissingSearch
:: if not defined EXPORT_MODULE_LOADED     goto MissingExport
:: if not defined STATISTICS_MODULE_LOADED goto MissingStatistics
:: if not defined PROGRESS_MODULE_LOADED   goto MissingProgress
:: if not defined CLEANUP_MODULE_LOADED    goto MissingCleanup


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

:MissingCore

echo.

if exist "%~dp001_Core.bat" (

    call "%~dp001_Core.bat" Core.Error
    call "%~dp001_Core.bat" Core.PrintLine

)

echo.
echo Required module not initialized.
echo.
echo     001_Core.bat
echo.

if exist "%~dp001_Core.bat" (

    call "%~dp001_Core.bat" Core.PrintLine
    call "%~dp001_Core.bat" Core.Normal

)

exit /b 1


::=======================================================================
:: RESERVED ERROR LABELS
::=======================================================================

:MissingScan
exit /b 1

:MissingMenu
exit /b 1

:MissingSearch
exit /b 1

:MissingExport
exit /b 1

:MissingStatistics
exit /b 1

:MissingProgress
exit /b 1

:MissingCleanup
exit /b 1