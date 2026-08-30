@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT_DIR=%~dp0"
set "BUILD_DIR=%ROOT_DIR%target\debug"

cd /d "%ROOT_DIR%"
cargo build
if errorlevel 1 exit /b %errorlevel%

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

if exist "%BUILD_DIR%\data" rmdir /s /q "%BUILD_DIR%\data"
if exist "%ROOT_DIR%data" (
    mkdir "%BUILD_DIR%\data" >nul 2>&1
    xcopy "%ROOT_DIR%data\*" "%BUILD_DIR%\data\" /E /I /Y /Q >nul
) else (
    mkdir "%BUILD_DIR%\data" >nul 2>&1
)

if exist "%ROOT_DIR%Doukutsu.exe" copy /Y "%ROOT_DIR%Doukutsu.exe" "%BUILD_DIR%\Doukutsu.exe" >nul

if exist "%ROOT_DIR%DoConfig.exe" copy /Y "%ROOT_DIR%DoConfig.exe" "%BUILD_DIR%\DoConfig.exe" >nul

if exist "%ROOT_DIR%data-overlay" (
    xcopy "%ROOT_DIR%data-overlay\*" "%BUILD_DIR%\data\" /E /I /Y /Q >nul
)

cd "%BUILD_DIR%"

if exist "%BUILD_DIR%\miserysmeditation.exe" (
    "%BUILD_DIR%\miserysmeditation.exe"
    exit /b %errorlevel%
)

cd "%ROOT_DIR%"

echo Executable not found in %BUILD_DIR%
exit /b 1
