@echo off
setlocal EnableExtensions EnableDelayedExpansion
::#####################################################################
::
::  Module      : 01_Core.inc
::  Project     : MPLAB SOURCE EXPORT TOOL
::  Version     : 3.0
::  Author      : Tan Doan
::
::  Description
::      - Banner
::      - Config
::      - Global Variables
::      - Common Functions
::      - Detect Project
::      - Format Functions
::
::#####################################################################


::=====================================================================
:: CONFIG
::=====================================================================

set "VERSION=3.0"

set "OUTPUT=All_Selected_Source.txt"

set "SCAN_EXT=*.c *.h"

:: Ignore Folder

set "IGNORE1=\build\"
set "IGNORE2=\dist\"
set "IGNORE3=\Debug\"
set "IGNORE4=\Release\"
set "IGNORE5=\nbproject\"
set "IGNORE6=\objects\"


::=====================================================================
:: GLOBAL VARIABLES
::=====================================================================

set FILE_COUNT=0
set EXPORT_COUNT=0

set TOTAL_LINES=0
set TOTAL_SIZE=0
set TOTAL_CHARS=0
set TOTAL_COMMENT=0

set START_TIME=
set END_TIME=

set PROJECT=
set PROJECT_PATH=%CD%

set BAR_WIDTH=40

set TEMP_FILE=%TEMP%\mplab_export.tmp



::=====================================================================
:: INITIALIZE
::=====================================================================

call :Initialize

goto :eof



::#####################################################################
:: FUNCTIONS
::#####################################################################



::=====================================================================
:: Initialize
::=====================================================================

:Initialize

cls

call :PrintLine

echo.
echo              MPLAB SOURCE EXPORT TOOL v%VERSION%
echo.
call :PrintLine

echo.

echo Initializing...

echo.

set START_TIME=%TIME%

call :DetectProject

goto :eof



::=====================================================================
:: Detect Project
::=====================================================================

:DetectProject

set PROJECT=

for %%D in ("%CD%") do (

    echo %%~nxD | findstr /I ".X" >nul

    if not errorlevel 1 (

        set PROJECT=%%~nxD

    )

)

if not defined PROJECT (

    for %%D in ("%CD%") do (

        set PROJECT=%%~nxD

    )

)

echo Project

echo     %PROJECT%

echo.

echo Folder

echo     %PROJECT_PATH%

echo.

goto :eof



::=====================================================================
:: Print Line
::=====================================================================

:PrintLine

echo ================================================================

goto :eof



::=====================================================================
:: Print Title
::=====================================================================

:PrintTitle

echo.
call :PrintLine

echo %~1

call :PrintLine
echo.

goto :eof



::=====================================================================
:: Reset Statistics
::=====================================================================

:ResetStatistics

set FILE_COUNT=0
set EXPORT_COUNT=0

set TOTAL_LINES=0
set TOTAL_SIZE=0
set TOTAL_CHARS=0
set TOTAL_COMMENT=0

goto :eof



::=====================================================================
:: Get Relative Path
::=====================================================================

:RelativePath

set "RELATIVE_PATH=%~1"

set "RELATIVE_PATH=!RELATIVE_PATH:%PROJECT_PATH%\=!"

goto :eof



::=====================================================================
:: Format Size
::=====================================================================

:FormatSize

set SIZE=%~1

if %SIZE% LSS 1024 (

    set SIZE_TEXT=%SIZE% B

    goto :eof

)

set /a KB=SIZE/1024

if %KB% LSS 1024 (

    set SIZE_TEXT=%KB% KB

    goto :eof

)

set /a MB=KB/1024

set SIZE_TEXT=%MB% MB

goto :eof



::=====================================================================
:: Current Time
::=====================================================================

:GetCurrentTime

set CURRENT_TIME=%TIME%

goto :eof



::=====================================================================
:: Finish Timer
::=====================================================================

:FinishTimer

set END_TIME=%TIME%

goto :eof



::=====================================================================
:: INFO
::=====================================================================

:Info

color 0B

goto :eof



::=====================================================================
:: WARNING
::=====================================================================

:Warning

color 0E

goto :eof



::=====================================================================
:: ERROR
::=====================================================================

:Error

color 0C

goto :eof



::=====================================================================
:: NORMAL
::=====================================================================

:Normal

color 0F

goto :eof



::=====================================================================
:: Pause
::=====================================================================

:Pause

echo.

pause

goto :eof



::=====================================================================
:: Exit Program
::=====================================================================

:Exit

call :Normal

echo.

echo Program Finished.

echo.

exit /b