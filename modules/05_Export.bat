:: Part 1 05_Export.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 05_Export.bat
::  Purpose     : Source Export Management
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Export API Dispatcher
::      • Export Runtime Services
::      • Export Engine
::      • Output Writer
::      • Export Statistics
::
::#######################################################################

::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined EXPORT_MODULE_LOADED (
    set "EXPORT_MODULE_LOADED=1"
)

::=======================================================================
:: EXPORT CONFIGURATION
::=======================================================================

set "EXPORT_OUTPUT_FILE=%OUTPUT_FILE%"

set "EXPORT_APPEND_MODE=0"  rem TODO
set "EXPORT_WRITE_SEPARATOR=1"


::=======================================================================
:: EXPORT SESSION
::=======================================================================

set "EXPORT_SOURCE_DATABASE="

set "EXPORT_START_TIME="
set "EXPORT_END_TIME="
set "EXPORT_DURATION="


::=======================================================================
:: CURRENT EXPORT RECORD
::=======================================================================

set "EXPORT_CURRENT_PATH="
set "EXPORT_CURRENT_FILE="
set "EXPORT_CURRENT_NAME="
set "EXPORT_CURRENT_EXT="

set /A EXPORT_CURRENT_SIZE=0
set /A EXPORT_CURRENT_INDEX=0





::=======================================================================
:: GETTER OUTPUT
::=======================================================================



set "EXPORT_GET_START_TIME="
set "EXPORT_GET_END_TIME="
set "EXPORT_GET_DURATION="
set "EXPORT_GET_OUTPUT_FILE="


::=======================================================================
:: API DISPATCHER
::
:: Usage
::     call "05_Export.bat" Export.Start
::     call "05_Export.bat" Export.ExportDatabase
::     
::
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

::-----------------------------------------------------------------------
:: Export Controller
::-----------------------------------------------------------------------

if /I "%~1"=="Export.Start"                 goto Export_Start
if /I "%~1"=="Export.Initialize"            goto Export_Initialize
if /I "%~1"=="Export.Finalize"              goto Export_Finalize
if /I "%~1"=="Export.Clear"                 goto Export_Clear
if /I "%~1"=="Export.UpdateEndTime"         goto Export_UpdateEndTime
if /I "%~1"=="Export.CalculateDuration"     goto Export_CalculateDuration

::-----------------------------------------------------------------------
:: Export Database Engine
::-----------------------------------------------------------------------

if /I "%~1"=="Export.ExportDatabase"        goto Export_ExportDatabase
if /I "%~1"=="Export.ReadRecord"            goto Export_ReadRecord
if /I "%~1"=="Export.ExportRecord"          goto Export_ExportRecord
if /I "%~1"=="Export.ExportFile"            goto Export_ExportFile

::-----------------------------------------------------------------------
:: Output Writer
::-----------------------------------------------------------------------

if /I "%~1"=="Export.WriteDocumentHeader"   goto Export_WriteDocumentHeader
if /I "%~1"=="Export.WriteFileHeader"       goto Export_WriteFileHeader
if /I "%~1"=="Export.WriteFileContent"      goto Export_WriteFileContent
if /I "%~1"=="Export.WriteFileFooter"       goto Export_WriteFileFooter
if /I "%~1"=="Export.WriteDocumentFooter"   goto Export_WriteDocumentFooter

::-----------------------------------------------------------------------
:: Export Statistics
::-----------------------------------------------------------------------

if /I "%~1"=="Export.GetSummary"            goto Export_GetSummary
if /I "%~1"=="Export.GetStartTime"          goto Export_GetStartTime
if /I "%~1"=="Export.GetEndTime"            goto Export_GetEndTime
if /I "%~1"=="Export.GetDuration"           goto Export_GetDuration
if /I "%~1"=="Export.GetOutputFile"         goto Export_GetOutputFile


::-----------------------------------------------------------------------
:: Unknown API
::-----------------------------------------------------------------------

call "%~dp001_Core.bat" Core.Error

call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Unknown Export API:
echo     %~1
echo.
echo Usage:
echo     call "05_Export.bat" Export.Start
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 05_Export.bat

::#######################################################################
:: EXPORT CONTROLLER API
::#######################################################################


::=======================================================================
:: Export.Start
::-----------------------------------------------------------------------
:: Purpose
::     Execute export workflow.
::
:: Workflow
::     Initialize
::         ↓
::     Export Database
::         ↓
::     Write Footer
::         ↓
::     Print Summary
::
:: Responsibilities
::     • Initialize export session
::     • Export source database
::     • Finalize output file
::     • Display export summary
::
:: NOTE
::     Export.Start acts as the controller.
::     Export logic is delegated to other APIs.
::=======================================================================

:Export_Start

call "%~f0" Export.Initialize "%~2"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.ExportDatabase

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.Finalize

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%



::=======================================================================
:: Export.Initialize
::-----------------------------------------------------------------------
:: Purpose
::     Initialize export runtime.
::
:: Responsibilities
::     • Reset export session
::     • Get source database
::     • Prepare output file
::     • Save export start time
::
:: Output
::     EXPORT_SOURCE_DATABASE
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::=======================================================================

:Export_Initialize

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set "EXPORT_SOURCE_DATABASE=%~2"

call "%~dp001_Core.bat" Core.FileExists "%EXPORT_SOURCE_DATABASE%"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.Clear

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~dp001_Core.bat" Core.GetCurrentTime

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set "EXPORT_START_TIME=%CURRENT_TIME%"

call "%~f0" Export.WriteDocumentHeader

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)



exit /b %RC_SUCCESS%

::=======================================================================
:: Export.Finalize
::-----------------------------------------------------------------------
:: Purpose
::     Finalize export session.
::
:: Workflow
::
::     UpdateEndTime
::          ↓
::     Calculate Duration
::          ↓
::     Write Document Footer
::
:: Responsibilities
::     • Save export end time
::     • Calculate export duration
::     • Finalize export document
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Export_Finalize

call "%~f0" Export.UpdateEndTime
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Export.CalculateDuration
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Export.WriteDocumentFooter
if errorlevel 1 exit /b %ERRORLEVEL%

exit /b %RC_SUCCESS%





::=======================================================================
:: Export.UpdateEndTime
::-----------------------------------------------------------------------
:: Purpose
::     Update export end time.
::
:: Responsibilities
::     • Get current system time
::     • Save export end time
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Export_UpdateEndTime

call "%~dp001_Core.bat" Core.GetCurrentTime

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set "EXPORT_END_TIME=%CURRENT_TIME%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Export.CalculateDuration
::-----------------------------------------------------------------------
:: Purpose
::     Calculate export duration.
::
:: Responsibilities
::     • Calculate elapsed time
::     • Save export duration
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Export_CalculateDuration

rem TODO
rem Calculate duration from
rem EXPORT_START_TIME
rem EXPORT_END_TIME

set "EXPORT_DURATION=00:00:00"

exit /b %RC_SUCCESS%


::=======================================================================
:: Export.Clear
::-----------------------------------------------------------------------
:: Purpose
::     Clear export runtime data.
::
:: Responsibilities
::     • Reset current export record
::     • Reset export statistics
::     • Reset runtime variables
::
:: NOTE
::      Source database is preserved.
::=======================================================================

:Export_Clear

::-----------------------------------------------------------------------
:: Current Export Record
::-----------------------------------------------------------------------

set "EXPORT_CURRENT_PATH="
set "EXPORT_CURRENT_FILE="
set "EXPORT_CURRENT_NAME="
set "EXPORT_CURRENT_EXT="

set /A EXPORT_CURRENT_SIZE=0
set /A EXPORT_CURRENT_INDEX=0


::-----------------------------------------------------------------------
:: Export Session
::-----------------------------------------------------------------------

set "EXPORT_START_TIME="
set "EXPORT_END_TIME="
set "EXPORT_DURATION="



exit /b %RC_SUCCESS%

:: Part 3 05_Export.bat

::#######################################################################
:: EXPORT DATABASE API
::#######################################################################


::=======================================================================
:: Export.ExportDatabase
::-----------------------------------------------------------------------
:: Purpose
::     Export all records from source database.
::
:: Workflow
::     Read Record
::          ↓
::     Export Record
::
:: Responsibilities
::     • Verify source database
::     • Read each database record
::     • Delegate export processing
::
:: Input
::     EXPORT_SOURCE_DATABASE
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::     RC_FILE_NOT_FOUND
::=======================================================================

:Export_ExportDatabase

if "%EXPORT_SOURCE_DATABASE%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

call "%~dp001_Core.bat" Core.FileExists "%EXPORT_SOURCE_DATABASE%"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

for /F "usebackq delims=" %%R in ("%EXPORT_SOURCE_DATABASE%") do (

    call "%~f0" Export.ExportRecord "%%R"

    if errorlevel 1 (
        exit /b %ERRORLEVEL%
    )

)

exit /b %RC_SUCCESS%

::=======================================================================
:: Export.ReadRecord
::-----------------------------------------------------------------------
:: Purpose
::     Parse one database record.
::
:: Database Format
::
::     FullPath|FileName|BaseName|Extension|FileSize
::
:: Input
::     %2 = Database record
::
:: Output
::     EXPORT_CURRENT_PATH
::     EXPORT_CURRENT_RELATIVE
::     EXPORT_CURRENT_FILE
::     EXPORT_CURRENT_NAME
::     EXPORT_CURRENT_EXT
::     EXPORT_CURRENT_SIZE
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Export_ReadRecord

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

for /F "tokens=1-6 delims=|" %%A in ("%~2") do (

    set "EXPORT_CURRENT_PATH=%%~A"

    set "EXPORT_CURRENT_RELATIVE=%%~B"

    set "EXPORT_CURRENT_FILE=%%~C"

    set "EXPORT_CURRENT_NAME=%%~D"

    set "EXPORT_CURRENT_EXT=%%~E"

    set "EXPORT_CURRENT_SIZE=%%~F"

)

exit /b %RC_SUCCESS%

::=======================================================================
:: Export.ExportRecord
::-----------------------------------------------------------------------
:: Purpose
::     Export one database record.
::
:: Responsibilities
::     • Parse database record
::     • Save current export record
::     • Delegate file export
::
:: Database Format
::
::     FullPath|FileName|BaseName|Extension|FileSize
::
:: Input
::     %2 = Database record
::
:: Output
::     EXPORT_CURRENT_PATH
::     EXPORT_CURRENT_FILE
::     EXPORT_CURRENT_NAME
::     EXPORT_CURRENT_EXT
::     EXPORT_CURRENT_SIZE
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Export_ExportRecord

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set /A EXPORT_CURRENT_INDEX+=1

call "%~f0" Export.ReadRecord "%~2"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.ExportFile

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%

:: Part 4 05_Export.bat

::=======================================================================
:: Export.ExportFile
::-----------------------------------------------------------------------
:: Purpose
::     Export current source file.
::
:: Workflow
::
::     Verify File
::          ↓
::     Write Header
::          ↓
::     Write Content
::          ↓
::     Write Footer
::          ↓
::     Update Statistics
::
:: Input
::     EXPORT_CURRENT_PATH
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::     RC_EXPORT_FAILED
::=======================================================================

:Export_ExportFile

if "%EXPORT_CURRENT_PATH%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

call "%~dp001_Core.bat" Core.FileExists "%EXPORT_CURRENT_PATH%"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.WriteFileHeader

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.WriteFileContent

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Export.WriteFileFooter

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~dp006_Statistics.bat" Statistics.AddFile

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%



:: Part 5 05_Export.bat

::#######################################################################
:: OUTPUT WRITER API
::#######################################################################


::=======================================================================
:: Export.WriteDocumentHeader
::-----------------------------------------------------------------------
:: Purpose
::     Write export document header.
::
:: Responsibilities
::     • Create output file
::     • Write export information
::=======================================================================

:Export_WriteDocumentHeader

if "%EXPORT_OUTPUT_FILE%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

(
echo ============================================================
echo MPLAB SOURCE EXPORT TOOL
echo ============================================================
echo.
echo Project    : %PROJECT_NAME%
echo Start Time : %EXPORT_START_TIME%
echo.
echo ============================================================
echo.
)>"%EXPORT_OUTPUT_FILE%"

exit /b %RC_SUCCESS%



::=======================================================================
:: Export.WriteFileHeader
::-----------------------------------------------------------------------
:: Purpose
::     Write current file header.
::
:: Responsibilities
::     • Display file separator
::     • Display file information
::=======================================================================

:Export_WriteFileHeader

>>"%EXPORT_OUTPUT_FILE%" (

echo ------------------------------------------------------------
echo File #%EXPORT_CURRENT_INDEX% : %EXPORT_CURRENT_FILE%
echo Path : %EXPORT_CURRENT_PATH%
echo Size : %EXPORT_CURRENT_SIZE% bytes
echo ------------------------------------------------------------
echo.

)

exit /b %RC_SUCCESS%



::=======================================================================
:: Export.WriteFileContent
::-----------------------------------------------------------------------
:: Purpose
::     Write current file content.
::
:: Responsibilities
::     • Copy source file
::=======================================================================

:Export_WriteFileContent

type "%EXPORT_CURRENT_PATH%" >> "%EXPORT_OUTPUT_FILE%"

if errorlevel 1 (
    exit /b %RC_EXPORT_FAILED%
)

>>"%EXPORT_OUTPUT_FILE%" echo.

rem call "%~dp006_Statistics.bat" Statistics.AddLine "%LINE_COUNT%"
rem if errorlevel 1 exit /b %ERRORLEVEL%

rem call "%~dp006_Statistics.bat" Statistics.AddCharacter "%CHAR_COUNT%"
rem if errorlevel 1 exit /b %ERRORLEVEL%

exit /b %RC_SUCCESS%



::=======================================================================
:: Export.WriteFileFooter
::-----------------------------------------------------------------------
:: Purpose
::     Write current file footer.
::
:: Responsibilities
::     • Separate exported files
::=======================================================================

:Export_WriteFileFooter

>>"%EXPORT_OUTPUT_FILE%" (

echo.
echo ============================================================
echo.

)

exit /b %RC_SUCCESS%



::=======================================================================
:: Export.WriteDocumentFooter
::-----------------------------------------------------------------------
:: Purpose
::     Write export document footer.
::
:: Responsibilities
::     • Finish output file
::=======================================================================

:Export_WriteDocumentFooter

call "%~dp006_Statistics.bat" Statistics.GetSummary

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

>>"%EXPORT_OUTPUT_FILE%" (

echo.
echo ============================================================
echo End Time : %EXPORT_END_TIME%
echo Duration : %EXPORT_DURATION%
echo Files    : %STAT_GET_FILES%
echo ============================================================
echo End Of Export
echo ============================================================

)

exit /b %RC_SUCCESS%

:: Part 6 05_Export.bat

::#######################################################################
:: EXPORT STATISTICS API
::#######################################################################





::=======================================================================
:: Export.GetOutputFile
::-----------------------------------------------------------------------
:: Purpose
::     Get output file path.
::
:: Responsibilities
::    • Validate output file path
::    • Return output file path
::    
:: Output
::      EXPORT_GET_OUTPUT_FILE
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Export_GetOutputFile

if "%EXPORT_OUTPUT_FILE%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set "EXPORT_GET_OUTPUT_FILE=%EXPORT_OUTPUT_FILE%"

exit /b %RC_SUCCESS%


::=======================================================================
:: Export.GetSummary
::-----------------------------------------------------------------------
:: Purpose
::     Get export session summary.
::
:: Output
::     EXPORT_GET_START_TIME
::     EXPORT_GET_END_TIME
::     EXPORT_GET_DURATION
::     EXPORT_GET_OUTPUT_FILE
::=======================================================================

:Export_GetSummary

call "%~f0" Export.GetStartTime
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Export.GetEndTime
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Export.GetDuration
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Export.GetOutputFile
if errorlevel 1 exit /b %ERRORLEVEL%

exit /b %RC_SUCCESS%

::=======================================================================
:: Export.GetStartTime
::-----------------------------------------------------------------------
:: Purpose
::     Get export start time.
::
:: Output
::     EXPORT_GET_START_TIME
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Export_GetStartTime

set "EXPORT_GET_START_TIME=%EXPORT_START_TIME%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Export.GetEndTime
::-----------------------------------------------------------------------
:: Purpose
::     Get export end time.
::
:: Output
::     EXPORT_GET_END_TIME
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Export_GetEndTime

set "EXPORT_GET_END_TIME=%EXPORT_END_TIME%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Export.GetDuration
::-----------------------------------------------------------------------
:: Purpose
::     Get export duration.
::
:: Output
::     EXPORT_GET_DURATION
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Export_GetDuration

set "EXPORT_GET_DURATION=%EXPORT_DURATION%"

exit /b %RC_SUCCESS%


