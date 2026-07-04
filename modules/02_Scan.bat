::=====================================================================
:: Module 02
:: Scan Project
:: Part 1
::=====================================================================


::=====================================================================
:: Function : ScanProject
::=====================================================================

:ScanProject

call :Title

echo.
echo ===============================================================
echo                  SCANNING PROJECT
echo ===============================================================
echo.

set FILE_COUNT=0

if exist "%TEMP%\mplab_filelist.tmp" del "%TEMP%\mplab_filelist.tmp"

echo Searching source files...
echo.

call :ScanFolder "%PROJECT_PATH%"

echo.

echo Scan Complete.

echo.

goto :eof



::=====================================================================
:: Function : ScanFolder
::=====================================================================

:ScanFolder

set "CURRENT_FOLDER=%~1"

call :IsIgnored "%CURRENT_FOLDER%"

if "!IGNORE_FOLDER!"=="1" (

    goto :eof

)

echo Scanning

echo     %CURRENT_FOLDER%

echo.

for %%F in ("%CURRENT_FOLDER%\*.c") do (

    if exist "%%F" (

        echo %%~fF>>"%TEMP%\mplab_filelist.tmp"

    )

)

for %%F in ("%CURRENT_FOLDER%\*.h") do (

    if exist "%%F" (

        echo %%~fF>>"%TEMP%\mplab_filelist.tmp"

    )

)

for /d %%D in ("%CURRENT_FOLDER%\*") do (

    call :ScanFolder "%%~fD"

)

goto :eof



::=====================================================================
:: Function : IsIgnored
::=====================================================================

:IsIgnored

set IGNORE_FOLDER=0

echo %~1 | find /I "%IGNORE1%" >nul

if not errorlevel 1 set IGNORE_FOLDER=1

echo %~1 | find /I "%IGNORE2%" >nul

if not errorlevel 1 set IGNORE_FOLDER=1

echo %~1 | find /I "%IGNORE3%" >nul

if not errorlevel 1 set IGNORE_FOLDER=1

echo %~1 | find /I "%IGNORE4%" >nul

if not errorlevel 1 set IGNORE_FOLDER=1

echo %~1 | find /I "%IGNORE5%" >nul

if not errorlevel 1 set IGNORE_FOLDER=1

echo %~1 | find /I "%IGNORE6%" >nul

if not errorlevel 1 set IGNORE_FOLDER=1

goto :eof

::=====================================================================
:: Module 02
:: Scan Project
:: Part 2
::=====================================================================


::=====================================================================
:: Function : BuildFileList
::=====================================================================

:BuildFileList

echo.
echo Building File List...
echo.

if not exist "%TEMP%\mplab_filelist.tmp" (

    echo No source files found.
    goto :eof

)

sort "%TEMP%\mplab_filelist.tmp" /o "%TEMP%\mplab_filelist.tmp"

call :ClearFileArray

set FILE_COUNT=0
set TOTAL_SIZE=0

for /f "usebackq delims=" %%F in ("%TEMP%\mplab_filelist.tmp") do (

    call :AddFile "%%~fF"

)

echo.

echo File List Created.

echo.

goto :eof



::=====================================================================
:: Function : AddFile
::=====================================================================

:AddFile

set /a FILE_COUNT+=1

set FILE!FILE_COUNT!=%~1

for %%S in ("%~1") do (

    set /a TOTAL_SIZE+=%%~zS

)

goto :eof



::=====================================================================
:: Function : ClearFileArray
::=====================================================================

:ClearFileArray

for /L %%I in (1,1,5000) do (

    set FILE%%I=

)

goto :eof



::=====================================================================
:: Function : GetFileCount
::=====================================================================

:GetFileCount

echo.

echo ----------------------------------------------

echo Total Source Files

echo     %FILE_COUNT%

echo.

echo Total Size

echo     %TOTAL_SIZE% Bytes

echo ----------------------------------------------

echo.

goto :eof

