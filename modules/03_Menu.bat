:: Part 1 03_Menu.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 03_Menu.bat
::  Purpose     : Menu Management
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Main Menu
::      • User Input
::      • Menu Navigation
::      • Menu Validation
::      • Menu Dispatcher
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined MENU_MODULE_LOADED (
    set "MENU_MODULE_LOADED=1"
)


::=======================================================================
:: MENU CONFIGURATION
::=======================================================================

set "MENU_TITLE=MAIN MENU"

set "MENU_OPTION_1=Export All Source Files"
set "MENU_OPTION_2=Exit"

set "MENU_DEFAULT=1"

set /A MENU_MIN_OPTION=1
set /A MENU_MAX_OPTION=2


::=======================================================================
:: API DISPATCHER
::
:: Usage
::     call "03_Menu.bat" Menu.Start
::     call "03_Menu.bat" Menu.Show
::     call "03_Menu.bat" Menu.GetSelection
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

if /I "%~1"=="Menu.Start"           goto Menu_Start
if /I "%~1"=="Menu.Show"            goto Menu_Show
if /I "%~1"=="Menu.GetSelection"    goto Menu_GetSelection
if /I "%~1"=="Menu.Validate"        goto Menu_Validate
if /I "%~1"=="Menu.Dispatch"        goto Menu_Dispatch

call "%~dp001_Core.bat" Core.Error

call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Unknown Menu API:
echo     %~1
echo.
echo Usage:
echo     call "03_Menu.bat" Menu.Start
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 03_Menu.bat

::=======================================================================
:: MENU API
::=======================================================================

::=======================================================================
:: Menu.Start
::-----------------------------------------------------------------------
:: Purpose
::     Execute main menu workflow.
::
:: Responsibilities
::     • Display menu
::     • Read user selection
::     • Validate selection
::     • Dispatch selected action
::
:: NOTE
::     Menu.Start acts as the controller.
::     Business logic is delegated to other APIs.
::=======================================================================

:Menu_Start

:Menu_Loop

call "%~f0" Menu.Show

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Menu.GetSelection

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Menu.Validate

if errorlevel 1 (

    call "%~dp001_Core.bat" Core.Warning

    echo.
    echo Invalid selection.
    echo Please try again.
    echo.

    call "%~dp001_Core.bat" Core.Normal

    goto Menu_Loop

)

call "%~f0" Menu.Dispatch

set "MENU_RESULT=%ERRORLEVEL%"

if %MENU_RESULT% EQU %RC_SUCCESS% (
    goto Menu_Loop
)

if %MENU_RESULT% EQU %RC_USER_CANCEL% (
    exit /b %RC_SUCCESS%
)

exit /b %MENU_RESULT%

:: Part 3 03_Menu.bat

::#######################################################################
:: MENU DISPLAY API
::#######################################################################


::=======================================================================
:: Menu.Show
::-----------------------------------------------------------------------
:: Purpose
::     Display the main menu.
::
:: Responsibilities
::     • Display application menu
::     • Display available options
::
:: NOTE
::     This API performs display only.
::     No user input is processed here.
::=======================================================================

:Menu_Show

cls

call "%~dp001_Core.bat" Core.PrintBanner

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~dp001_Core.bat" Core.PrintCenter "%MENU_TITLE%"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

echo     [1] %MENU_OPTION_1%
echo.
echo     [2] %MENU_OPTION_2%

echo.

exit /b %RC_SUCCESS%

:: Part 4 03_Menu.bat

::#######################################################################
:: MENU INPUT API
::#######################################################################


::=======================================================================
:: Menu.GetSelection
::-----------------------------------------------------------------------
:: Purpose
::     Read user menu selection.
::
:: Responsibilities
::     • Prompt user for menu selection
::     • Store selected menu option
::
:: Output
::     MENU_SELECTED_OPTION
::
:: NOTE
::     This API only reads user input.
::     Validation is handled by Menu.Validate.
::=======================================================================

:Menu_GetSelection

set "MENU_SELECTED_OPTION="

echo.

set /P "MENU_SELECTED_OPTION=Select an option : "

echo.

exit /b %RC_SUCCESS%

:: Part 5 03_Menu.bat

::#######################################################################
:: MENU VALIDATION API
::#######################################################################


::=======================================================================
:: Menu.Validate
::-----------------------------------------------------------------------
:: Purpose
::     Validate the selected menu option.
::
:: Responsibilities
::     • Verify user selection
::     • Reject invalid options
::
:: Input
::     MENU_SELECTED_OPTION
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Menu_Validate

if "%MENU_SELECTED_OPTION%"=="1" (
    exit /b %RC_SUCCESS%
)

if "%MENU_SELECTED_OPTION%"=="2" (
    exit /b %RC_SUCCESS%
)

exit /b %RC_INVALID_PARAMETER%

:: Part 6 03_Menu.bat

::#######################################################################
:: MENU DISPATCH API
::#######################################################################


::=======================================================================
:: Menu.Dispatch
::-----------------------------------------------------------------------
:: Purpose
::     Dispatch the selected menu option.
::
:: Responsibilities
::     • Execute selected action
::     • Route control to corresponding module
::
:: Input
::     MENU_SELECTED_OPTION
::
:: Return
::     RC_SUCCESS
::     RC_ERROR
::=======================================================================

:Menu_Dispatch

if "%MENU_SELECTED_OPTION%"=="1" (

    call "%~dp005_Export.bat" Export.Start

    if errorlevel 1 (
        exit /b %ERRORLEVEL%
    )

    exit /b %RC_SUCCESS%

)

if "%MENU_SELECTED_OPTION%"=="2" (

    exit /b %RC_USER_CANCEL%

)

exit /b %RC_INVALID_PARAMETER%

:: Part 7 03_Menu.bat

::#######################################################################
:: RESERVED MENU API
::#######################################################################

::=======================================================================
:: Reserved For Future APIs
::-----------------------------------------------------------------------
::
:: Planned APIs
::
::     • Menu.ShowHeader
::     • Menu.ShowFooter
::     • Menu.ShowStatus
::     • Menu.LoadConfiguration
::     • Menu.SaveConfiguration
::     • Menu.Help
::     • Menu.About
::
:: NOTE
::     This section is intentionally reserved for future expansion.
::=======================================================================

:: Part 8 03_Menu.bat

::#######################################################################
:: END OF FILE
::#######################################################################

::=======================================================================
:: End of Module
::-----------------------------------------------------------------------
:: Module
::     03_Menu.bat
::
:: Description
::     Menu Management Framework
::
:: NOTE
::     End of module.
::=======================================================================