@echo off
REM Batch script to create desktop and start menu shortcuts for Dreamy School Management
REM Run this script after building the portable executable

set APP_NAME=Dreamy School Management
set EXE_NAME=Dreamy School Management 1.0.0.exe
set SCRIPT_DIR=%~dp0
set EXE_PATH=%SCRIPT_DIR%dist\%EXE_NAME%
set ICON_PATH=%SCRIPT_DIR%build\icon.ico

REM Check if executable exists
if not exist "%EXE_PATH%" (
    echo Error: Executable not found at %EXE_PATH%
    echo Please build the app first using: npm run build:win
    pause
    exit /b 1
)

echo Creating shortcuts for %APP_NAME%...
echo.

REM Get desktop and start menu paths
set DESKTOP=%USERPROFILE%\Desktop
set START_MENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Dreamy School

REM Create Start Menu folder if it doesn't exist
if not exist "%START_MENU%" mkdir "%START_MENU%"

REM Check if icon exists
if exist "%ICON_PATH%" (
    set ICON_LOCATION=%ICON_PATH%
    echo Using custom icon from build folder
) else (
    set ICON_LOCATION=%EXE_PATH%
    echo No custom icon found, using default exe icon
)

REM Create desktop shortcut using PowerShell
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%DESKTOP%\%APP_NAME%.lnk'); $Shortcut.TargetPath = '%EXE_PATH%'; $Shortcut.WorkingDirectory = '%SCRIPT_DIR%dist'; $Shortcut.Description = '%APP_NAME% - Desktop Application'; $Shortcut.IconLocation = '%ICON_LOCATION%'; $Shortcut.Save()"

REM Create start menu shortcut using PowerShell
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%START_MENU%\%APP_NAME%.lnk'); $Shortcut.TargetPath = '%EXE_PATH%'; $Shortcut.WorkingDirectory = '%SCRIPT_DIR%dist'; $Shortcut.Description = '%APP_NAME% - Desktop Application'; $Shortcut.IconLocation = '%ICON_LOCATION%'; $Shortcut.Save()"

echo.
echo Shortcuts created successfully!
echo - Desktop: %DESKTOP%\%APP_NAME%.lnk
echo - Start Menu: %START_MENU%\%APP_NAME%.lnk
echo.
echo You can now launch the app from Desktop or Start Menu!
echo.
pause

