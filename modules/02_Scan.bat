:: Part 1 02_Scan.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 02_Scan.bat
::  Purpose     : Project Scan Library
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Scan API Dispatcher
::      • Scan Runtime Services
::      • Directory Scanner
::      • File Filter
::      • Scan Database
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined SCAN_MODULE_LOADED (
    set "SCAN_MODULE_LOADED=1"
)


::=======================================================================
:: SCAN CONFIGURATION
::=======================================================================

set "SCAN_RECURSIVE=1"

set "SCAN_INCLUDE_HIDDEN=0"

set "SCAN_INCLUDE_SYSTEM=0"

::=======================================================================
:: GETTER OUTPUT
::=======================================================================

set "SCAN_GET_FILE_COUNT="
set "SCAN_GET_TOTAL_SIZE="
set "SCAN_GET_TOTAL_SIZE_TEXT="
set "SCAN_GET_DATABASE="

::-----------------------------------------------------------------------
:: Scan Database
::-----------------------------------------------------------------------

set "SCAN_DATABASE=%TEMP%\mplab_scan_database.tmp"

::=======================================================================
:: API DISPATCHER
::
:: Usage
::     call "02_Scan.bat" Scan.Initialize
::     call "02_Scan.bat" Scan.Start
::     
::
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)


::-----------------------------------------------------------------------
:: Scan Core API
::-----------------------------------------------------------------------

if /I "%~1"=="Scan.Initialize"        goto Scan_Initialize
if /I "%~1"=="Scan.Start"             goto Scan_Start
if /I "%~1"=="Scan.Clear"             goto Scan_Clear


::-----------------------------------------------------------------------
:: Directory Scanner
::-----------------------------------------------------------------------

if /I "%~1"=="Scan.ScanDirectory"     goto Scan_ScanDirectory
if /I "%~1"=="Scan.ReadFileInfo"      goto Scan_ReadFileInfo
if /I "%~1"=="Scan.ProcessFile"       goto Scan_ProcessFile


::-----------------------------------------------------------------------
:: File Filter
::-----------------------------------------------------------------------

if /I "%~1"=="Scan.ShouldIgnore"      goto Scan_ShouldIgnore


::-----------------------------------------------------------------------
:: Scan Database
::-----------------------------------------------------------------------

if /I "%~1"=="Scan.AddFile"           goto Scan_AddFile
if /I "%~1"=="Scan.GetFileCount"      goto Scan_GetFileCount
if /I "%~1"=="Scan.GetTotalSize"      goto Scan_GetTotalSize
if /I "%~1"=="Scan.GetDatabase"       goto Scan_GetDatabase
if /I "%~1"=="Scan.SaveResult"        goto Scan_SaveResult

::-----------------------------------------------------------------------
:: Unknown API
::-----------------------------------------------------------------------

call "%~dp001_Core.bat" Core.Error

call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Unknown Scan API:
echo     %~1
echo.
echo Usage:
echo     call "02_Scan.bat" Scan.Start
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 02_Scan.bat

::#######################################################################
:: SCAN CONTROL API
::#######################################################################


::=======================================================================
:: Scan.Initialize
::-----------------------------------------------------------------------
:: Purpose
::     Initialize scan runtime.
::
:: Responsibilities
::    • Initialize scan session
::    • Initialize scan configuration
::    • Reset runtime data
::=======================================================================

:Scan_Initialize

set "SCAN_ROOT=%PROJECT_PATH%"

if "%PROJECT_PATH%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

:: Reserved for future file list.
set "SCAN_LIST="

call "%~dp001_Core.bat" Core.GetCurrentTime

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set "SCAN_START_TIME=%CURRENT_TIME%"

if exist "%SCAN_DATABASE%" (
    del /f /q "%SCAN_DATABASE%"
)

call "%~f0" Scan.Clear

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%




::=======================================================================
:: Scan.Clear
::-----------------------------------------------------------------------
:: Purpose
::     Clear scan runtime data.
::
:: NOTE
::     Configuration is NOT modified.
::
::Responsibilities
::    • Clear current file information
::    • Reset scan statistics
::    • Reset runtime variables
::=======================================================================

:Scan_Clear

:: Reserved for future directory statistics.
set /A SCAN_DIRECTORY_COUNT=0

set "SCAN_CURRENT_PATH="
set "SCAN_CURRENT_FILE="
set "SCAN_CURRENT_NAME="
set "SCAN_CURRENT_EXT="
set "SCAN_CURRENT_DIR="
set "SCAN_CURRENT_RELATIVE="

set /A SCAN_CURRENT_SIZE=0

set "SCAN_END_TIME="

set /A SCAN_FILE_COUNT=0
set /A SCAN_TOTAL_SIZE=0

exit /b %RC_SUCCESS%



::=======================================================================
:: Scan.Start
::-----------------------------------------------------------------------
:: Purpose
::     Start project scanning.
::
:: Workflow
::     Initialize
::         ↓
::     Scan Directory
::         ↓
::     Print Summary
::=======================================================================

:Scan_Start

call "%~f0" Scan.Initialize
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Scan.ScanDirectory "%SCAN_ROOT%"
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~dp001_Core.bat" Core.GetCurrentTime
if errorlevel 1 exit /b %ERRORLEVEL%

set "SCAN_END_TIME=%CURRENT_TIME%"

exit /b %RC_SUCCESS%

:: Part 3 02_Scan.bat

::#######################################################################
:: SCAN ENGINE API
::#######################################################################


::=======================================================================
:: Scan.ScanDirectory
::-----------------------------------------------------------------------
:: Purpose
::     Scan all source files in the specified directory.
::
:: Input
::     %2 = Scan directory
::
:: Responsibilities
::     • Verify scan directory
::     • Enumerate source files
::     • Process each file
::     • Update scan statistics
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::     RC_FILE_NOT_FOUND
::=======================================================================

:Scan_ScanDirectory

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

call "%~dp001_Core.bat" Core.DirectoryExists "%~2"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

for %%E in (*.c *.h) do (

    for /R "%~2" %%F in (%%E) do (

        call "%~f0" Scan.ShouldIgnore "%%~fF"

        if not errorlevel 1 (

            call "%~f0" Scan.ProcessFile "%%~fF"

            if errorlevel 1 exit /b %ERRORLEVEL%

        )

    )

)

exit /b %RC_SUCCESS%



::=======================================================================
:: Scan.ProcessFile
::-----------------------------------------------------------------------
:: Purpose
::     Process a single source file.
::
:: Input
::     %2 = Full file path
::
:: Responsibilities
::     • Verify file
::     • Save current file information
::     • Update statistics
::     • Prepare for Export module
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::     RC_FILE_NOT_FOUND
::=======================================================================

:Scan_ProcessFile

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

call "%~dp001_Core.bat" Core.FileExists "%~2"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Scan.ReadFileInfo "%~2"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Scan.AddFile

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%

::=======================================================================
:: Scan.ReadFileInfo
::-----------------------------------------------------------------------
:: Purpose
::     Read metadata of current file.
::
:: Input
::     %2 = Full file path
::
:: Output
::     SCAN_CURRENT_PATH
::     SCAN_CURRENT_FILE
::     SCAN_CURRENT_NAME
::     SCAN_CURRENT_EXT
::     SCAN_CURRENT_DIR
::     SCAN_CURRENT_SIZE
::=======================================================================

:Scan_ReadFileInfo

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set "SCAN_CURRENT_PATH=%~f2"

call "%~dp001_Core.bat" Core.RelativePath "%SCAN_CURRENT_PATH%"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set "SCAN_CURRENT_RELATIVE=%RELATIVE_PATH%"

set "SCAN_CURRENT_FILE=%~nx2"

for %%A in ("%~2") do (

    set "SCAN_CURRENT_NAME=%%~nA"
    set "SCAN_CURRENT_EXT=%%~xA"
    set "SCAN_CURRENT_DIR=%%~dpA"
    set "SCAN_CURRENT_SIZE=%%~zA"

)

exit /b %RC_SUCCESS%

:: Part 4 02_Scan.bat

::#######################################################################
:: SCAN FILTER API
::#######################################################################


::=======================================================================
:: Scan.ShouldIgnore
::-----------------------------------------------------------------------
:: Purpose
::     Determine whether a file should be ignored.
::
:: Input
::     %2 = Full file path
::
:: Output
::     Return Code
::
:: Return
::     RC_SUCCESS             = Do not ignore
::     RC_SCAN_FAILED         = Ignore file
::     RC_INVALID_PARAMETER
::=======================================================================

:Scan_ShouldIgnore

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

for /L %%I in (1,1,%IGNORE_COUNT%) do (

    call set "CURRENT_IGNORE=%%IGNORE_DIR_%%I%%"

    call "%~dp001_Core.bat" Core.StringContains "%~2" "%CURRENT_IGNORE%"

    if not errorlevel 1 (
        exit /b %RC_SCAN_FAILED%
    )

)

exit /b %RC_SUCCESS%




:: Part 5 02_Scan.bat

::#######################################################################
:: SCAN STATISTICS API
::#######################################################################


::=======================================================================
:: Scan.AddFile
::-----------------------------------------------------------------------
:: Purpose
::     Add current file to scan statistics.
::
:: Input
::     SCAN_CURRENT_SIZE
::
:: Responsibilities
::     • Increase scanned file count
::     • Increase total scanned size
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Scan_AddFile

set /A SCAN_FILE_COUNT+=1

set /A SCAN_TOTAL_SIZE+=SCAN_CURRENT_SIZE

call "%~f0" Scan.SaveResult

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%



::=======================================================================
:: Scan.GetFileCount
::-----------------------------------------------------------------------
:: Purpose
::     Get total scanned file count.
::
:: Output
::     SCAN_FILE_COUNT
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Scan_GetFileCount

set "SCAN_GET_FILE_COUNT=%SCAN_FILE_COUNT%"

exit /b %RC_SUCCESS%



::=======================================================================
:: Scan.GetTotalSize
::-----------------------------------------------------------------------
:: Purpose
::     Get total scanned size.
::
:: Output
::     SCAN_TOTAL_SIZE
::     SCAN_TOTAL_SIZE_TEXT
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Scan_GetTotalSize

call "%~dp001_Core.bat" Core.FormatSize "%SCAN_TOTAL_SIZE%"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set "SCAN_GET_TOTAL_SIZE=%SCAN_TOTAL_SIZE%"
set "SCAN_GET_TOTAL_SIZE_TEXT=%SIZE_TEXT%"

exit /b %RC_SUCCESS%




::=======================================================================
:: Scan.GetDatabase
::-----------------------------------------------------------------------
:: Purpose
::     Get scan database path.
::
:: Output
::     SCAN_GET_DATABASE
::
:: Return
::     RC_SUCCESS
::
:: NOTE
::     Database path is stored in SCAN_DATABASE.
::     This API exists for interface consistency.
::
::=======================================================================

:Scan_GetDatabase

if not exist "%SCAN_DATABASE%" (
    exit /b %RC_FILE_NOT_FOUND%
)

set "SCAN_GET_DATABASE=%SCAN_DATABASE%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Scan.SaveResult
::-----------------------------------------------------------------------
:: Purpose
::     Save current scan result to scan database.
::
:: Database Format
::
::     FullPath|RelativePath|FileName|BaseName|Extension|FileSize
::
:: Example
::
::     D:\Project\main.c|main.c|main|.c|1520
::
:: Input
::     SCAN_CURRENT_PATH
::     SCAN_CURRENT_FILE
::     SCAN_CURRENT_NAME
::     SCAN_CURRENT_EXT
::     SCAN_CURRENT_SIZE
::
:: Return
::     RC_SUCCESS
::
:: Database Format v1
::
::=======================================================================

:Scan_SaveResult

if "%SCAN_CURRENT_PATH%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if "%SCAN_DATABASE%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

>>"%SCAN_DATABASE%" (
    echo(%SCAN_CURRENT_PATH%^|%SCAN_CURRENT_RELATIVE%^|%SCAN_CURRENT_FILE%^|%SCAN_CURRENT_NAME%^|%SCAN_CURRENT_EXT%^|%SCAN_CURRENT_SIZE%
)

exit /b %RC_SUCCESS%