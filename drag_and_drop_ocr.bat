@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ------------------------------------------------------------
rem Drag & Drop OCR runner for yomitoku
rem - Supports: PDF, image file, folder containing images
rem - Output text analysis: analysis_results
rem - Output figures: figure
rem ------------------------------------------------------------

set "SCRIPT_DIR=%~dp0"
pushd "%SCRIPT_DIR%" >nul

set "VENV_ACTIVATE=%SCRIPT_DIR%.venv\Scripts\activate.bat"
if not exist "%VENV_ACTIVATE%" (
    echo [ERROR] Virtual environment not found: "%VENV_ACTIVATE%"
    echo Create it first, for example: uv venv
    popd >nul
    exit /b 1
)

call "%VENV_ACTIVATE%"
if errorlevel 1 (
    echo [ERROR] Failed to activate virtual environment.
    popd >nul
    exit /b 1
)

where yomitoku >nul 2>&1
if errorlevel 1 (
    echo [ERROR] yomitoku command not found in this environment.
    echo Install it in .venv first.
    popd >nul
    exit /b 1
)

set "OUT_DIR=%SCRIPT_DIR%analysis_results"
set "FIG_DIR=%SCRIPT_DIR%figure"

if not exist "%OUT_DIR%" mkdir "%OUT_DIR%"
if not exist "%FIG_DIR%" mkdir "%FIG_DIR%"

if "%~1"=="" (
    echo [INFO] Drop PDF, image file, or folder onto this bat file.
    popd >nul
    exit /b 0
)

set /a processed=0
set /a skipped=0

:process_args
if "%~1"=="" goto done
set "TARGET=%~1"

if not exist "%TARGET%" (
    echo [WARN] Not found: "%TARGET%"
    set /a skipped+=1
    shift
    goto process_args
)

if exist "%TARGET%\*" (
    echo [INFO] Processing folder: "%TARGET%"
    call :run_ocr "%TARGET%"
    shift
    goto process_args
)

call :is_supported_file "%TARGET%"
if "!supported!"=="1" (
    echo [INFO] Processing file: "%TARGET%"
    call :run_ocr "%TARGET%"
) else (
    echo [WARN] Unsupported file type: "%TARGET%"
    set /a skipped+=1
)

shift
goto process_args

:run_ocr
set "INPUT=%~1"
rem md format gives a readable analysis output while keeping structured data.
yomitoku "%INPUT%" -f md -o "%OUT_DIR%" --figure --figure_dir "%FIG_DIR%"
if errorlevel 1 (
    echo [ERROR] OCR failed: "%INPUT%"
) else (
    set /a processed+=1
)
exit /b

:is_supported_file
set "supported=0"
set "EXT=%~x1"
if /I "%EXT%"==".pdf" set "supported=1"
if /I "%EXT%"==".png" set "supported=1"
if /I "%EXT%"==".jpg" set "supported=1"
if /I "%EXT%"==".jpeg" set "supported=1"
if /I "%EXT%"==".bmp" set "supported=1"
if /I "%EXT%"==".tif" set "supported=1"
if /I "%EXT%"==".tiff" set "supported=1"
if /I "%EXT%"==".webp" set "supported=1"
if /I "%EXT%"==".gif" set "supported=1"
exit /b

:done
echo.
echo [DONE] Processed: %processed%  Skipped: %skipped%
echo [DONE] Analysis output: "%OUT_DIR%"
echo [DONE] Figure output:   "%FIG_DIR%"

popd >nul
exit /b 0
