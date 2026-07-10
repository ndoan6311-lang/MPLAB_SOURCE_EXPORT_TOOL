:: Part 1 06_Statistics.bat

@echo off

::#######################################################################
::
::  MPLAB SOURCE EXPORT TOOL
::
::-----------------------------------------------------------------------
::  Module      : 06_Statistics.bat
::  Purpose     : Statistics Library
::  Version     : 5.1
::  Author      : Tan Doan
::
::-----------------------------------------------------------------------
::  Responsibilities
::
::      • Statistics Runtime
::      • Statistics Collector
::      • Statistics Query API
::
::#######################################################################


::=======================================================================
:: MODULE INITIALIZATION
::=======================================================================

if not defined STATISTICS_MODULE_LOADED (
    set "STATISTICS_MODULE_LOADED=1"
)


::=======================================================================
:: RUNTIME VARIABLES
::=======================================================================

::-----------------------------------------------------------------------
:: Internal Counters (Private)
::-----------------------------------------------------------------------

set /A STAT_FILE_COUNT=0

set /A STAT_LINE_COUNT=0

set /A STAT_CHARACTER_COUNT=0

set /A STAT_COMMENT_COUNT=0


::-----------------------------------------------------------------------
:: Query Output (Public)
::-----------------------------------------------------------------------

set "STAT_GET_FILES="

set "STAT_GET_LINES="

set "STAT_GET_CHARACTERS="

set "STAT_GET_COMMENTS="


::=======================================================================
:: API DISPATCHER
::
:: Usage
::      call "06_Statistics.bat" Statistics.Start
::      call "06_Statistics.bat" Statistics.AddFile
::      call "06_Statistics.bat" Statistics.GetSummary
::
::=======================================================================

if "%~1"=="" (
    exit /b %RC_SUCCESS%
)


::-----------------------------------------------------------------------
:: Runtime API
::-----------------------------------------------------------------------

if /I "%~1"=="Statistics.Start"          goto Statistics_Start
if /I "%~1"=="Statistics.Reset"          goto Statistics_Reset


::-----------------------------------------------------------------------
:: Update API
::-----------------------------------------------------------------------

if /I "%~1"=="Statistics.AddFile"        goto Statistics_AddFile
if /I "%~1"=="Statistics.AddLine"        goto Statistics_AddLine
if /I "%~1"=="Statistics.AddCharacter"   goto Statistics_AddCharacter
if /I "%~1"=="Statistics.AddComment"     goto Statistics_AddComment


::-----------------------------------------------------------------------
:: Query API
::-----------------------------------------------------------------------

if /I "%~1"=="Statistics.GetSummary"        goto Statistics_GetSummary
if /I "%~1"=="Statistics.GetFileCount"      goto Statistics_GetFileCount
if /I "%~1"=="Statistics.GetLineCount"      goto Statistics_GetLineCount
if /I "%~1"=="Statistics.GetCharacterCount" goto Statistics_GetCharacterCount
if /I "%~1"=="Statistics.GetCommentCount"   goto Statistics_GetCommentCount

::-----------------------------------------------------------------------
:: Unknown API
::-----------------------------------------------------------------------

call "%~dp001_Core.bat" Core.Error

call "%~dp001_Core.bat" Core.PrintLine

echo.
echo Unknown Statistics API:
echo     %~1
echo.
echo Usage:
echo     call "06_Statistics.bat" Statistics.Start
echo.

call "%~dp001_Core.bat" Core.PrintLine

call "%~dp001_Core.bat" Core.Normal

exit /b %RC_INVALID_PARAMETER%

:: Part 2 06_Statistics.bat

::#######################################################################
:: RUNTIME API
::#######################################################################


::=======================================================================
:: Statistics.Start
::-----------------------------------------------------------------------
:: Purpose
::     Start statistics session.
::
:: Responsibilities
::     • Initialize statistics runtime
::     • Reset all counters
::
:: Workflow
::     Reset
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_Start

call "%~f0" Statistics.Reset

if errorlevel 1 (
    exit /b %ERRORLEVEL%
)

exit /b %RC_SUCCESS%



::=======================================================================
:: Statistics.Reset
::-----------------------------------------------------------------------
:: Purpose
::     Reset statistics runtime.
::
:: NOTE
::     Internal runtime variables only.
::
:: Responsibilities
::     • Reset file counter
::     • Reset line counter
::     • Reset character counter
::     • Reset comment counter
::     • Clear query output variables
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_Reset

::-----------------------------------------------------------------------
:: Internal Counters
::-----------------------------------------------------------------------

set /A STAT_FILE_COUNT=0

set /A STAT_LINE_COUNT=0

set /A STAT_CHARACTER_COUNT=0

set /A STAT_COMMENT_COUNT=0


::-----------------------------------------------------------------------
:: Query Output
::-----------------------------------------------------------------------

set "STAT_GET_FILES="

set "STAT_GET_LINES="

set "STAT_GET_CHARACTERS="

set "STAT_GET_COMMENTS="


exit /b %RC_SUCCESS%

:: Part 3 06_Statistics.bat

::#######################################################################
:: STATISTICS UPDATE API
::#######################################################################

::=======================================================================
:: Statistics.AddFile
::-----------------------------------------------------------------------
:: Purpose
::     Increase exported file count.
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_AddFile

set /A STAT_FILE_COUNT+=1

exit /b %RC_SUCCESS%



::=======================================================================
:: Statistics.AddLine
::-----------------------------------------------------------------------
:: Purpose
::     Add exported line count.
::
:: Input
::     %2 = Line count
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Statistics_AddLine

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set /A STAT_LINE_COUNT+=%~2

exit /b %RC_SUCCESS%



::=======================================================================
:: Statistics.AddCharacter
::-----------------------------------------------------------------------
:: Purpose
::     Add exported character count.
::
:: Input
::     %2 = Character count
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Statistics_AddCharacter

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set /A STAT_CHARACTER_COUNT+=%~2

exit /b %RC_SUCCESS%



::=======================================================================
:: Statistics.AddComment
::-----------------------------------------------------------------------
:: Purpose
::     Add exported comment line count.
::
:: Input
::     %2 = Comment line count
::
:: Return
::     RC_SUCCESS
::     RC_INVALID_PARAMETER
::=======================================================================

:Statistics_AddComment

if "%~2"=="" (
    exit /b %RC_INVALID_PARAMETER%
)

set /A STAT_COMMENT_COUNT+=%~2

exit /b %RC_SUCCESS%

:: Part 4 06_Statistics.bat

::#######################################################################
:: QUERY API
::#######################################################################





::=======================================================================
:: Statistics.GetSummary
::-----------------------------------------------------------------------
:: Purpose
::     Get all statistics values.
::
:: Output
::     STAT_GET_FILES
::     STAT_GET_LINES
::     STAT_GET_CHARACTERS
::     STAT_GET_COMMENTS
::=======================================================================

:Statistics_GetSummary

call "%~f0" Statistics.GetFileCount
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Statistics.GetLineCount
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Statistics.GetCharacterCount
if errorlevel 1 exit /b %ERRORLEVEL%

call "%~f0" Statistics.GetCommentCount
if errorlevel 1 exit /b %ERRORLEVEL%

exit /b %RC_SUCCESS%

::=======================================================================
:: Statistics.GetFileCount
::-----------------------------------------------------------------------
:: Purpose
::     Get exported file count.
::
:: Output
::     STAT_GET_FILES
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_GetFileCount

set "STAT_GET_FILES=%STAT_FILE_COUNT%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Statistics.GetLineCount
::-----------------------------------------------------------------------
:: Purpose
::     Get exported line count.
::
:: Output
::     STAT_GET_LINES
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_GetLineCount

set "STAT_GET_LINES=%STAT_LINE_COUNT%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Statistics.GetCharacterCount
::-----------------------------------------------------------------------
:: Purpose
::     Get exported character count.
::
:: Output
::     STAT_GET_CHARACTERS
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_GetCharacterCount

set "STAT_GET_CHARACTERS=%STAT_CHARACTER_COUNT%"

exit /b %RC_SUCCESS%

::=======================================================================
:: Statistics.GetCommentCount
::-----------------------------------------------------------------------
:: Purpose
::     Get exported comment line count.
::
:: Output
::     STAT_GET_COMMENTS
::
:: Return
::     RC_SUCCESS
::=======================================================================

:Statistics_GetCommentCount

set "STAT_GET_COMMENTS=%STAT_COMMENT_COUNT%"

exit /b %RC_SUCCESS%