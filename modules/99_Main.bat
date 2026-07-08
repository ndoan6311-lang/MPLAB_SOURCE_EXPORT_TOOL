@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 99_Main.bat
::  Purpose     : Application Controller
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Load Framework
::      • Initialize Application
::      • Execute Main Workflow
::      • Shutdown Application
::      • Central Error Handling
::
::#######################################################################


::=======================================================================
:: LOAD FRAMEWORK
::=======================================================================

call "%~dp090_Bootstrap.bat"

echo.
echo Bootstrap Return = %ERRORLEVEL%
echo.

pause


::=======================================================================
:: APPLICATION ENTRY
::=======================================================================

call :Main

exit /b %ERRORLEVEL%



::=======================================================================
:: MAIN
::=======================================================================

:Main

call :Initialize
if errorlevel 1 goto OnError

call :PreRunCheck
if errorlevel 1 goto OnError

call :Run
if errorlevel 1 goto OnError

call :PostRun
if errorlevel 1 goto OnError

call :Shutdown
if errorlevel 1 goto OnError

exit /b %RC_SUCCESS%



::=======================================================================
:: INITIALIZE APPLICATION
::=======================================================================

:Initialize

call "%~dp001_Core.bat" Core.Initialize
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp001_Core.bat" Core.PrintBanner
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp001_Core.bat" Core.DetectProject
if errorlevel 1 exit /b %ERRORLEVEL%

exit /b %RC_SUCCESS%



::=======================================================================
:: PRE-RUN CHECK
::=======================================================================

:PreRunCheck

rem Reserved for future validation
rem
rem Example:
rem     - Verify Project
rem     - Verify Output Folder
rem     - Verify Write Permission
rem     - Verify Disk Space

exit /b %RC_SUCCESS%



::=======================================================================
:: RUN APPLICATION
::=======================================================================

:Run

call "%~dp003_Menu.bat" Menu.Start

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%



::=======================================================================
:: POST-RUN
::=======================================================================

:PostRun

rem Reserved for future processing
rem
rem Example:
rem     - Save Configuration
rem     - Write Log
rem     - Generate Report

exit /b %RC_SUCCESS%



::=======================================================================
:: SHUTDOWN
::=======================================================================

:Shutdown

call "%~dp001_Core.bat" Core.Exit

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%



::=======================================================================
:: ERROR HANDLER
::=======================================================================

:OnError

set "EXIT_CODE=%ERRORLEVEL%"

call "%~dp001_Core.bat" Core.Error

echo.
call "%~dp001_Core.bat" Core.PrintLine

echo.
echo APPLICATION ERROR
echo.
echo Exit Code : %EXIT_CODE%
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

exit /b %EXIT_CODE%