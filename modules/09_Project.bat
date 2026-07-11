@echo off

if not defined PROJECT_MODULE_LOADED (
    set "PROJECT_MODULE_LOADED=1"
)

::=======================================================================
:: GETTER OUTPUT
::=======================================================================

set "PROJECT_GET_PATH="
set "PROJECT_GET_NAME="
set "PROJECT_GET_OUTPUT_FILE="
set "PROJECT_GET_SOURCE_ROOT="
set "PROJECT_GET_NBPROJECT="

if "%~1"=="" exit /b %RC_SUCCESS%

if /I "%~1"=="Project.Select"           goto Project_Select
if /I "%~1"=="Project.Verify"           goto Project_Verify

if /I "%~1"=="Project.GetPath"          goto Project_GetPath
if /I "%~1"=="Project.GetName"          goto Project_GetName
if /I "%~1"=="Project.GetOutputFile"    goto Project_GetOutputFile
if /I "%~1"=="Project.GetSourceRoot"    goto Project_GetSourceRoot
if /I "%~1"=="Project.GetNbProject"     goto Project_GetNbProject

exit /b %RC_INVALID_PARAMETER%
























:Project_Select

set "PROJECT_PATH="

for /f "usebackq delims=" %%I in (`
    powershell -NoProfile -ExecutionPolicy Bypass -STA ^
    -File "%~dp0..\scripts\SelectProject.ps1"
`) do (

    if not defined PROJECT_PATH (
        set "PROJECT_PATH=%%I"
    )

)

if not defined PROJECT_PATH (
    exit /b %RC_USER_CANCEL%
)

exit /b %RC_SUCCESS%


















:Project_Verify

if not defined PROJECT_PATH (
    exit /b %RC_PROJECT_NOT_FOUND%
)

if not exist "%PROJECT_PATH%\nbproject" (
    exit /b %RC_PROJECT_NOT_FOUND%
)

exit /b %RC_SUCCESS%













:Project_GetPath

if not defined PROJECT_PATH (
    exit /b %RC_PROJECT_NOT_FOUND%
)

set "PROJECT_GET_PATH=%PROJECT_PATH%"

exit /b %RC_SUCCESS%







:Project_GetName

if not defined PROJECT_PATH (
    exit /b %RC_PROJECT_NOT_FOUND%
)

for %%A in ("%PROJECT_PATH%") do (
    set "PROJECT_GET_NAME=%%~nxA"
)

exit /b %RC_SUCCESS%







:Project_GetOutputFile

if not defined PROJECT_PATH (
    exit /b %RC_PROJECT_NOT_FOUND%
)

set "PROJECT_GET_OUTPUT_FILE=%PROJECT_PATH%\%APP_OUTPUT%"

exit /b %RC_SUCCESS%







:Project_GetSourceRoot

if not defined PROJECT_PATH (
    exit /b %RC_PROJECT_NOT_FOUND%
)

set "PROJECT_GET_SOURCE_ROOT=%PROJECT_PATH%"

exit /b %RC_SUCCESS%








:Project_GetNbProject

if not defined PROJECT_PATH (
    exit /b %RC_PROJECT_NOT_FOUND%
)

set "PROJECT_GET_NBPROJECT=%PROJECT_PATH%\nbproject"

exit /b %RC_SUCCESS%













