:: Part 1 01_Core.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 01_Core.bat
::  Purpose     : Core Framework Library
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Global Configuration
::      • Framework API Dispatcher
::      • Core Runtime Services
::      • Console Utilities
::      • Project Utilities
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined CORE_MODULE_LOADED (
    set "CORE_MODULE_LOADED=1"
)


::=======================================================================
:: APPLICATION CONFIGURATION
::=======================================================================

set "APP_NAME=MPLAB SOURCE EXPORT TOOL"
set "APP_VERSION=5.1"
set "APP_AUTHOR=Tan Doan"

set "APP_LICENSE=MIT"
set "APP_BUILD=2026.07.05"

set "APP_COPYRIGHT=(C) 2026 Tan Doan"

set "APP_OUTPUT=All_Selected_Source.txt"


::=======================================================================
:: SCAN CONFIGURATION
::=======================================================================

set "SCAN_PATTERN=*.c *.h"

set /A IGNORE_COUNT=6

set "IGNORE_DIR_1=\build\"
set "IGNORE_DIR_2=\dist\"
set "IGNORE_DIR_3=\Debug\"
set "IGNORE_DIR_4=\Release\"
set "IGNORE_DIR_5=\nbproject\"
set "IGNORE_DIR_6=\objects\"


::=======================================================================
:: USER INTERFACE CONFIGURATION
::=======================================================================

set "LINE="

for /L %%I in (1,1,%BAR_WIDTH%) do (
    set "LINE=!LINE!="
)

::=======================================================================
:: RETURN CODES
::=======================================================================

::--------------------------------------------------
:: General
::--------------------------------------------------

set "RC_SUCCESS=0"
set "RC_ERROR=1"

::--------------------------------------------------
:: API
::--------------------------------------------------

set "RC_INVALID_PARAMETER=2"

::--------------------------------------------------
:: Search / String
::--------------------------------------------------

set "RC_NO_MATCH=3"

::--------------------------------------------------
:: File System
::--------------------------------------------------

set "RC_FILE_NOT_FOUND=4"
set "RC_PROJECT_NOT_FOUND=5"
set "RC_EXPORT_FAILED=6"

::--------------------------------------------------
:: Runtime
::--------------------------------------------------

set "RC_SCAN_FAILED=10"
set "RC_MENU_ABORT=11"
set "RC_USER_CANCEL=12"

::=======================================================================
:: API DISPATCHER
::
:: Usage
::     call "01_Core.bat" Core.Initialize
::     call "01_Core.bat" Core.PrintBanner
::     call "01_Core.bat" Core.Info
::
:: Console
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

if /I "%~1"=="Core.Initialize"       goto Core_Initialize
if /I "%~1"=="Core.Exit"             goto Core_Exit

if /I "%~1"=="Core.PrintBanner"      goto Core_PrintBanner
if /I "%~1"=="Core.PrintLine"        goto Core_PrintLine
if /I "%~1"=="Core.PrintCenter"      goto Core_PrintCenter

if /I "%~1"=="Core.Info"             goto Core_Info
if /I "%~1"=="Core.Warning"          goto Core_Warning
if /I "%~1"=="Core.Error"            goto Core_Error
if /I "%~1"=="Core.Success"          goto Core_Success
if /I "%~1"=="Core.Normal"           goto Core_Normal

if /I "%~1"=="Core.Pause"            goto Core_Pause

if /I "%~1"=="Core.DetectProject"    goto Core_DetectProject
if /I "%~1"=="Core.RelativePath"     goto Core_RelativePath
if /I "%~1"=="Core.FormatSize"       goto Core_FormatSize
if /I "%~1"=="Core.GetCurrentTime"   goto Core_GetCurrentTime

if /I "%~1"=="Core.FileExists"       goto Core_FileExists
if /I "%~1"=="Core.DirectoryExists"  goto Core_DirectoryExists
if /I "%~1"=="Core.FormatDuration"   goto Core_FormatDuration

::-----------------------------------------------------------------------
:: String API
::-----------------------------------------------------------------------

if /I "%~1"=="Core.StringContains"   goto Core_StringContains
if /I "%~1"=="Core.StringEquals"     goto Core_StringEquals
if /I "%~1"=="Core.StringStartsWith" goto Core_StringStartsWith
if /I "%~1"=="Core.StringEndsWith"   goto Core_StringEndsWith
if /I "%~1"=="Core.StringReplace"    goto Core_StringReplace
if /I "%~1"=="Core.StringTrim"       goto Core_StringTrim
if /I "%~1"=="Core.StringSplit"      goto Core_StringSplit
if /I "%~1"=="Core.StringLength"     goto Core_StringLength

call "%~f0" Core.Error

call "%~f0" Core.PrintLine

echo.
echo Unknown Core API:
echo     %~1
echo.
echo.
echo Usage:
echo     call "01_Core.bat" Core.Initialize

call "%~f0" Core.PrintLine

call "%~f0" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 01_Core.bat

::=======================================================================
:: CORE API
::=======================================================================

::=======================================================================
:: Core.Initialize
::-----------------------------------------------------------------------
:: Purpose
::     Initialize application runtime.
::
:: Responsibilities
::    • Clear console
::    • Reset console color
::    • Initialize session variables
::    • Prepare runtime environment
::=======================================================================

:Core_Initialize

cls

call "%~f0" Core.Normal

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

::--------------------------------------------------
:: Session Variables
::--------------------------------------------------

set "PROJECT_NAME="
set "PROJECT_PATH=%CD%"
set "OUTPUT_FILE=%APP_OUTPUT%"

set "START_TIME=%TIME%"
set "END_TIME="

set "CURRENT_TIME="
set "ELAPSED_TIME="

set "TEMP_FILE=%TEMP%\mplab_export.tmp"



exit /b %RC_SUCCESS%





::=======================================================================
:: Core.Exit
::-----------------------------------------------------------------------
:: Purpose
::     Shutdown application.
::
:: NOTE
::     Statistics summary will be expanded after
::     06_Statistics.bat is completed.
::=======================================================================

:Core_Exit

call "%~f0" Core.Normal

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

rem Cleanup runtime
rem (future)

exit /b %RC_SUCCESS%

:: Part 3 01_Core.bat

::#######################################################################
:: CONSOLE OUTPUT API
::#######################################################################


::=======================================================================
:: Core.PrintLine
::-----------------------------------------------------------------------
:: Purpose
::     Print separator line.
::
:: Usage
::     call "%~dp001_Core.bat" Core.PrintLine
::=======================================================================

:Core_PrintLine

echo %LINE%

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.PrintCenter
::-----------------------------------------------------------------------
:: Purpose
::     Print section title.
::
:: Usage
::     call "%~dp001_Core.bat" Core.PrintCenter "SCAN PROJECT"
::     Print section title.
::
:: Notes
::     The title is printed with a fixed left margin.
::
:: TODO
::     Dynamic center alignment in future versions.
::=======================================================================

:Core_PrintCenter

if "%~2"=="" exit /b %RC_INVALID_PARAMETER%

echo.

call "%~f0" Core.PrintLine

echo.

echo                        %~2

echo.

call "%~f0" Core.PrintLine

echo.

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.PrintBanner
::-----------------------------------------------------------------------
:: Purpose
::     Print application banner.
::
:: Usage
::     call "%~dp001_Core.bat" Core.PrintBanner
::=======================================================================

:Core_PrintBanner

call "%~f0" Core.PrintLine

echo.
echo                 %APP_NAME%
echo.
echo                 Version    : %APP_VERSION%
echo                 Author     : %APP_AUTHOR%
echo                 Build      : %APP_BUILD%
echo                 License    : %APP_LICENSE%
echo.
echo                 %APP_COPYRIGHT%
echo.

call "%~f0" Core.PrintLine

echo.

exit /b %RC_SUCCESS%

:: Part 4 01_Core.bat

::#######################################################################
:: UTILITY API
::#######################################################################


::=======================================================================
:: Core.DetectProject
::-----------------------------------------------------------------------
:: Purpose
::     Detect current MPLAB project.
::
:: Output
::     PROJECT_NAME
::     PROJECT_PATH
::=======================================================================

:Core_DetectProject

set "PROJECT_NAME="
set "PROJECT_PATH=%CD%"

for %%D in ("%CD%") do (

    if /I "%%~xD"==".X" (
        set "PROJECT_NAME=%%~nxD"
    )

)

if not defined PROJECT_NAME (

    for %%D in ("%CD%") do (
        set "PROJECT_NAME=%%~nxD"
    )

)

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.RelativePath
::-----------------------------------------------------------------------
:: Purpose
::     Convert absolute path to project relative path.
::
:: Input
::     %2 = Full file path
::
:: Output
::     RELATIVE_PATH
:: NOTE
::     Requires Delayed Expansion.
::     Caller must enable delayed expansion.
::=======================================================================

:Core_RelativePath

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

setlocal EnableDelayedExpansion

set "TEMP_PATH=%~2"

set "TEMP_PATH=!TEMP_PATH:%PROJECT_PATH%\=!"

endlocal & (
    set "RELATIVE_PATH=%TEMP_PATH%"
)

exit /b %RC_SUCCESS%

::=======================================================================
:: Core.FileExists
::-----------------------------------------------------------------------
:: Purpose
::     Verify that a file exists.
::
:: Input
::     %2 = File path
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::=======================================================================

:Core_FileExists

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if exist "%~2" (
    exit /b %RC_SUCCESS%
)

exit /b %RC_FILE_NOT_FOUND%

::=======================================================================
:: Core.DirectoryExists
::-----------------------------------------------------------------------
:: Purpose
::     Verify that a directory exists.
::
:: Input
::     %2 = Directory path
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::=======================================================================

:Core_DirectoryExists

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if exist "%~2\" (
    exit /b %RC_SUCCESS%
)

exit /b %RC_FILE_NOT_FOUND%

::=======================================================================
:: Core.FormatSize
::-----------------------------------------------------------------------
:: Purpose
::     Convert file size to readable text.
::
:: Input
::     %2 = Size (Bytes)
::
:: Output
::     SIZE_TEXT
::=======================================================================

:Core_FormatSize

if "%~2"=="" exit /b %RC_INVALID_PARAMETER%

set /A SIZE=%~2

if %SIZE% LSS 1024 (

    set "SIZE_TEXT=%SIZE% Bytes"
    exit /b %RC_SUCCESS%

)

set /A KB=SIZE/1024

if %KB% LSS 1024 (

    set "SIZE_TEXT=%KB% KB"
    exit /b %RC_SUCCESS%

)

set /A MB=KB/1024

if %MB% LSS 1024 (

    set "SIZE_TEXT=%MB% MB"
    exit /b %RC_SUCCESS%

)

set /A GB=MB/1024

set "SIZE_TEXT=%GB% GB"

exit /b %RC_SUCCESS%

::=======================================================================
:: Core.FormatDuration
::-----------------------------------------------------------------------
:: Purpose
::     Format elapsed time.
::
:: Input
::     %2 = Duration text
::
:: Output
::     DURATION_TEXT
::=======================================================================

:Core_FormatDuration

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set "DURATION_TEXT=%~2"

exit /b %RC_SUCCESS%

::=======================================================================
:: Core.GetCurrentTime
::-----------------------------------------------------------------------
:: Purpose
::     Save current system time.
::
:: Output
::     CURRENT_TIME
::=======================================================================

:Core_GetCurrentTime

set "CURRENT_TIME=%TIME%"

exit /b %RC_SUCCESS%

:: Part 5 01_Core.bat

::#######################################################################
:: CONSOLE CONTROL API
::#######################################################################


::=======================================================================
:: Core.Info
::-----------------------------------------------------------------------
:: Purpose
::     Set console color to Information.
::
:: Usage
::     call "%~dp001_Core.bat" Core.Info
::=======================================================================

:Core_Info

color 0B

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.Warning
::-----------------------------------------------------------------------
:: Purpose
::     Set console color to Warning.
::
:: Usage
::     call "%~dp001_Core.bat" Core.Warning
::=======================================================================

:Core_Warning

color 0E

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.Error
::-----------------------------------------------------------------------
:: Purpose
::     Set console color to Error.
::
:: Usage
::     call "%~dp001_Core.bat" Core.Error
::=======================================================================

:Core_Error

color 0C

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.Success
::-----------------------------------------------------------------------
:: Purpose
::     Set console color to Success.
::
:: Usage
::     call "%~dp001_Core.bat" Core.Success
::=======================================================================

:Core_Success

color 0A

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.Normal
::-----------------------------------------------------------------------
:: Purpose
::     Restore default console color.
::
:: Usage
::     call "%~dp001_Core.bat" Core.Normal
::=======================================================================

:Core_Normal

color 0F

exit /b %RC_SUCCESS%



::=======================================================================
:: Core.Pause
::-----------------------------------------------------------------------
:: Purpose
::     Pause application until user presses a key.
::
:: Usage
::     call "%~dp001_Core.bat" Core.Pause
::=======================================================================

:Core_Pause

echo.

pause

exit /b %RC_SUCCESS%

:: Part 6 01_Core.bat

::#######################################################################
:: STRING API
::#######################################################################

::=======================================================================
:: Core.StringContains
::-----------------------------------------------------------------------
:: Purpose
::     Determine whether a string contains another string.
::
:: Usage
::     call "%~dp001_Core.bat" Core.StringContains "Text" "Keyword"
::
:: Input
::     %2 = Source text
::     %3 = Search text
::
:: Return
::     RC_SUCCESS
::         Search text found.
::
::     RC_FILE_NOT_FOUND
::         Search text not found.
::
::     RC_INVALID_PARAMETER
::=======================================================================

:Core_StringContains

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if "%~3"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

echo(%~2| find /I "%~3" >nul

if errorlevel 1 (
    exit /b %RC_NO_MATCH%
)

exit /b %RC_SUCCESS%

::=======================================================================
:: Core.StringEquals
::-----------------------------------------------------------------------
:: Purpose
::     Compare two strings for equality.
::
:: Usage
::     call "%~dp001_Core.bat" Core.StringEquals "Text1" "Text2"
::
:: Input
::     %2 = First string
::     %3 = Second string
::
:: Return
::     RC_SUCCESS
::         Strings are equal.
::
::     RC_FILE_NOT_FOUND
::         Strings are different.
::
::     RC_INVALID_PARAMETER
::=======================================================================

:Core_StringEquals

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if "%~3"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if /I "%~2"=="%~3" (
    exit /b %RC_SUCCESS%
)

exit /b %RC_NO_MATCH%





:Core_StringTrim

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set "STRING_RESULT=%~2"

:: Trim bên trái
for /f "tokens=* delims= " %%A in ("%STRING_RESULT%") do (
    set "STRING_RESULT=%%A"
)

:: Trim bên phải
:TrimRight

if not "%STRING_RESULT%"=="" (
    if "%STRING_RESULT:~-1%"==" " (
        set "STRING_RESULT=%STRING_RESULT:~0,-1%"
        goto TrimRight
    )
)

exit /b %RC_SUCCESS%