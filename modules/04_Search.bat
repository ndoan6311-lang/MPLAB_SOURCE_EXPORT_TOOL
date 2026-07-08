:: Part 1 04_Search.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 04_Search.bat
::  Purpose     : Search Management
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Search Source Files
::      • Manage Search Results
::      • Search Filtering
::      • Search Query Services
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined SEARCH_MODULE_LOADED (
    set "SEARCH_MODULE_LOADED=1"
)


::=======================================================================
:: SEARCH CONFIGURATION
::=======================================================================

set "SEARCH_RESULT_FILE=%TEMP%\mplab_search_result.tmp"

set "SEARCH_DATABASE="

set /A SEARCH_RESULT_COUNT=0

::=======================================================================
:: API DISPATCHER
::
:: Usage
::     call "04_Search.bat" Search.Start
::     call "04_Search.bat" Search.FindFiles
::     call "04_Search.bat" Search.ClearResults
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)

if /I "%~1"=="Search.Start"          goto Search_Start
if /I "%~1"=="Search.Initialize"     goto Search_Initialize
if /I "%~1"=="Search.SetCriteria"    goto Search_SetCriteria
if /I "%~1"=="Search.Match"          goto Search_Match
if /I "%~1"=="Search.MatchField"     goto Search_MatchField
if /I "%~1"=="Search.FindFiles"      goto Search_FindFiles
if /I "%~1"=="Search.ClearResults"   goto Search_ClearResults
if /I "%~1"=="Search.AddResult"      goto Search_AddResult
if /I "%~1"=="Search.GetResultCount" goto Search_GetResultCount
if /I "%~1"=="Search.GetResult"      goto Search_GetResult
if /I "%~1"=="Search.PrintSummary"   goto Search_PrintSummary
if /I "%~1"=="Search.ReadRecord"     goto Search_ReadRecord

call "%~dp001_Core.bat" Core.Error

call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Unknown Search API:
echo     %~1
echo.
echo Usage:
echo     call "04_Search.bat" Search.Start
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 04_Search.bat

::=======================================================================
:: SEARCH API
::=======================================================================

::=======================================================================
:: Search.Start
::-----------------------------------------------------------------------
:: Purpose
::     Execute search workflow.
::
:: Workflow
::     Initialize
::         ↓
::     Find Files
::
:: Responsibilities
::     • Initialize search session
::     • Search scan database
::     • Build search result list
::
:: NOTE
::     Search.Start acts as the controller.
::     Search logic is delegated to other APIs.
::=======================================================================

:Search_Start

call "%~f0" Search.Initialize

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Search.SetCriteria "%~2"

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Search.FindFiles

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~f0" Search.PrintSummary

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%

:: Part 3 04_Search.bat

::=======================================================================
:: SEARCH INITIALIZATION API
::=======================================================================

::=======================================================================
:: Search.Initialize
::-----------------------------------------------------------------------
:: Purpose
::     Initialize search runtime.
::
:: Responsibilities
::     • Reset search session
::     • Clear previous search results
::     • Get scan database
::
:: Output
::      SEARCH_DATABASE
::          Path to Scan Database
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::=======================================================================

:Search_Initialize

call "%~f0" Search.ClearResults

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

call "%~dp002_Scan.bat" Scan.GetDatabase

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

set "SEARCH_DATABASE=%SCAN_GET_DATABASE%"

exit /b %RC_SUCCESS%

:: Part 4 04_Search.bat

::=======================================================================
:: SEARCH RESULT API
::=======================================================================

::=======================================================================
:: Search.ClearResults
::-----------------------------------------------------------------------
:: Purpose
::     Clear search runtime data.
::
:: Responsibilities
::     • Delete previous search result file
::     • Reset search result count
::     • Reset current search record
::
:: NOTE
::     Scan Database is NOT modified.
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Search_ClearResults

if exist "%SEARCH_RESULT_FILE%" (
    del /Q "%SEARCH_RESULT_FILE%"
)

set /A SEARCH_RESULT_COUNT=0

set "SEARCH_CURRENT_PATH="
set "SEARCH_CURRENT_FILE="
set "SEARCH_CURRENT_NAME="
set "SEARCH_CURRENT_EXT="
set "SEARCH_CURRENT_SIZE="

exit /b %RC_SUCCESS%

:: Part 5 04_Search.bat

::=======================================================================
:: SEARCH DATABASE API
::=======================================================================

::=======================================================================
:: Search.ReadRecord
::-----------------------------------------------------------------------
:: Purpose
::     Read a record from Scan Database.
::
:: Input
::     %2 = Database record
::
:: Database Format
::
::     FullPath|FileName|BaseName|Extension|FileSize
::
:: Responsibilities
::     • Parse database record
::     • Update current search record
::
:: Output
::     SEARCH_CURRENT_PATH
::     SEARCH_CURRENT_FILE
::     SEARCH_CURRENT_NAME
::     SEARCH_CURRENT_EXT
::     SEARCH_CURRENT_SIZE
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Search_ReadRecord

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

for /F "tokens=1-5 delims=|" %%A in ("%~2") do (

    set "SEARCH_CURRENT_PATH=%%~A"
    set "SEARCH_CURRENT_FILE=%%~B"
    set "SEARCH_CURRENT_NAME=%%~C"
    set "SEARCH_CURRENT_EXT=%%~D"
    set "SEARCH_CURRENT_SIZE=%%~E"

)

exit /b %RC_SUCCESS%

:: Part 6 04_Search.bat

::=======================================================================
:: SEARCH CRITERIA API
::=======================================================================

::=======================================================================
:: Search.SetCriteria
::-----------------------------------------------------------------------
:: Purpose
::     Set search criteria.
::
:: Responsibilities
::     • Validate search criteria
::     • Save search criteria
::
:: Input
::     %2 = Search criteria
::
:: Output
::     SEARCH_CRITERIA
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Search_SetCriteria

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set "SEARCH_CRITERIA=%~2"

exit /b %RC_SUCCESS%

:: Part 7 04_Search.bat

::=======================================================================
:: SEARCH MATCH API
::=======================================================================

::=======================================================================
:: Search.MatchField
::-----------------------------------------------------------------------
:: Purpose
::     Compare one field with current search criteria.
::
:: Input
::     %2 = Text to compare
::
:: Return
::     RC_SUCCESS
::     RC_NO_MATCH
::     RC_INVALID_PARAMETER
::=======================================================================

:Search_MatchField

call "%~dp001_Core.bat" Core.StringContains "%~2" "%SEARCH_CRITERIA%"

exit /b %ERRORLEVEL%

::=======================================================================
:: Search.Match
::-----------------------------------------------------------------------
:: Purpose
::     Determine whether the current record matches
::     the specified search criteria.
::
:: Responsibilities
::     • Validate search criteria
::     • Compare current record
::     • Return match status
::
:: Input
::     SEARCH_CRITERIA
::     SEARCH_CURRENT_PATH
::     SEARCH_CURRENT_FILE
::     SEARCH_CURRENT_NAME
::     SEARCH_CURRENT_EXT
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::     RC_INVALID_PARAMETER
::=======================================================================

:Search_Match

if "%SEARCH_CRITERIA%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

call "%~f0" Search.MatchField "%SEARCH_CURRENT_PATH%"
if not errorlevel 1 exit /b %RC_SUCCESS%

call "%~f0" Search.MatchField "%SEARCH_CURRENT_FILE%"
if not errorlevel 1 exit /b %RC_SUCCESS%

call "%~f0" Search.MatchField "%SEARCH_CURRENT_NAME%"
if not errorlevel 1 exit /b %RC_SUCCESS%

call "%~f0" Search.MatchField "%SEARCH_CURRENT_EXT%"
if not errorlevel 1 exit /b %RC_SUCCESS%

exit /b %RC_NO_MATCH%

:: Part 8 04_Search.bat

::=======================================================================
:: SEARCH RESULT API
::=======================================================================

::=======================================================================
:: Search.AddResult
::-----------------------------------------------------------------------
:: Purpose
::     Add current record to search result database.
::
:: Responsibilities
::     • Save current search record
::     • Update search statistics
::
:: Database Format
::
::     FullPath|FileName|BaseName|Extension|FileSize
::
:: Input
::     SEARCH_CURRENT_PATH
::     SEARCH_CURRENT_FILE
::     SEARCH_CURRENT_NAME
::     SEARCH_CURRENT_EXT
::     SEARCH_CURRENT_SIZE
::
:: Output
::     SEARCH_RESULT_COUNT
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Search_AddResult

if "%SEARCH_CURRENT_PATH%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

>>"%SEARCH_RESULT_FILE%" (
    echo %SEARCH_CURRENT_PATH%^|%SEARCH_CURRENT_FILE%^|%SEARCH_CURRENT_NAME%^|%SEARCH_CURRENT_EXT%^|%SEARCH_CURRENT_SIZE%
)

set /A SEARCH_RESULT_COUNT+=1

exit /b %RC_SUCCESS%

:: Part 9 04_Search.bat

::=======================================================================
:: SEARCH ENGINE API
::=======================================================================

::=======================================================================
:: Search.FindFiles
::-----------------------------------------------------------------------
:: Purpose
::     Search records from Scan Database.
::
:: Workflow
::     Read Record
::          ↓
::     Match Criteria
::          ↓
::     Add Result
::
:: Responsibilities
::     • Read scan database
::     • Parse each record
::     • Match search criteria
::     • Save matched records
::
:: Input
::     SEARCH_DATABASE
::     SEARCH_CRITERIA
::
:: Output
::     SEARCH_RESULT_FILE
::     SEARCH_RESULT_COUNT
::
:: Return
::     RC_SUCCESS
::     RC_FILE_NOT_FOUND
::=======================================================================

:Search_FindFiles

if "%SEARCH_DATABASE%"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if not exist "%SEARCH_DATABASE%" (
    exit /b %RC_FILE_NOT_FOUND%
)

for /F "usebackq delims=" %%R in ("%SEARCH_DATABASE%") do (

    call "%~f0" Search.ReadRecord "%%R"

    if errorlevel 1 (
        exit /b %ERRORLEVEL%
    )

    call "%~f0" Search.Match

    if not errorlevel 1 (

        call "%~f0" Search.AddResult

        if errorlevel 1 (
            exit /b %ERRORLEVEL%
        )

    )

)

exit /b %RC_SUCCESS%

:: Part 10 04_Search.bat

::=======================================================================
:: SEARCH RESULT API
::=======================================================================

::=======================================================================
:: Search.GetResult
::-----------------------------------------------------------------------
:: Purpose
::     Get a search result by index.
::
:: Input
::     %2 = Result index (1-based)
::
:: Output
::     SEARCH_RESULT
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::     RC_FILE_NOT_FOUND
::=======================================================================

:Search_GetResult

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

if not exist "%SEARCH_RESULT_FILE%" (
    exit /b %RC_FILE_NOT_FOUND%
)

set "SEARCH_RESULT="

set /A SEARCH_INDEX=0

for /F "usebackq delims=" %%A in ("%SEARCH_RESULT_FILE%") do (

    set /A SEARCH_INDEX+=1

    if !SEARCH_INDEX! EQU %~2 (
        set "SEARCH_RESULT=%%A"
        exit /b %RC_SUCCESS%
    )

)

exit /b %RC_FILE_NOT_FOUND%

:: Part 11 04_Search.bat

::=======================================================================
:: SEARCH SUMMARY API
::=======================================================================

::=======================================================================
:: Search.PrintSummary
::-----------------------------------------------------------------------
:: Purpose
::     Print search summary.
::
:: Responsibilities
::     • Display search criteria
::     • Display search result count
::
:: Output
::     SEARCH_CRITERIA
::     SEARCH_RESULT_COUNT
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Search_PrintSummary

call "%~dp001_Core.bat" Core.PrintCenter "SEARCH SUMMARY"

echo     Search Criteria : %SEARCH_CRITERIA%
echo     Results Found   : %SEARCH_RESULT_COUNT%

echo.

exit /b %RC_SUCCESS%

:: Part 12 04_Search.bat

::=======================================================================
:: RESERVED API
::=======================================================================

::=======================================================================
:: Search.GetResults
::-----------------------------------------------------------------------
:: Reserved for future implementation.
::
:: Purpose
::     Retrieve all search results.
::=======================================================================

:: :Search_GetResults



::=======================================================================
:: Search.RemoveResult
::-----------------------------------------------------------------------
:: Reserved for future implementation.
::
:: Purpose
::     Remove a result from search database.
::=======================================================================

:: :Search_RemoveResult



::=======================================================================
:: Search.SortResults
::-----------------------------------------------------------------------
:: Reserved for future implementation.
::
:: Purpose
::     Sort search results.
::=======================================================================

:: :Search_SortResults



::=======================================================================
:: Search.ExportResults
::-----------------------------------------------------------------------
:: Reserved for future implementation.
::
:: Purpose
::     Export search results to another module.
::=======================================================================

:: :Search_ExportResults



::=======================================================================
:: End of Module
::=======================================================================

:: Part 13 04_Search.bat

::#######################################################################
::
::  END OF MODULE
::
::-----------------------------------------------------------------------
::  Module : 04_Search.bat
::
::#######################################################################




