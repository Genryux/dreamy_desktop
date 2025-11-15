# PowerShell script to create desktop and start menu shortcuts for Dreamy School Management
# Run this script after building the portable executable

$appName = "Dreamy School Management"
$exePath = Join-Path $PSScriptRoot "dist\Dreamy School Management 1.0.0.exe"
$exeName = "Dreamy School Management 1.0.0.exe"

# Check if the executable exists
if (-not (Test-Path $exePath)) {
    Write-Host "Error: Executable not found at $exePath" -ForegroundColor Red
    Write-Host "Please build the app first using: npm run build:win" -ForegroundColor Yellow
    exit 1
}

# Get desktop and start menu paths
$desktopPath = [Environment]::GetFolderPath("Desktop")
$startMenuPath = Join-Path ([Environment]::GetFolderPath("StartMenu")) "Programs\Dreamy School"

# Create Start Menu folder if it doesn't exist
if (-not (Test-Path $startMenuPath)) {
    New-Item -ItemType Directory -Path $startMenuPath -Force | Out-Null
}

# Create WScript Shell object
$shell = New-Object -ComObject WScript.Shell

# Check for custom icon
$iconPath = Join-Path $PSScriptRoot "build\icon.ico"
$iconLocation = $exePath  # Default to exe icon
if (Test-Path $iconPath) {
    $iconLocation = $iconPath
    Write-Host "Using custom icon from build folder" -ForegroundColor Cyan
} else {
    Write-Host "No custom icon found, using default exe icon" -ForegroundColor Yellow
}

# Function to create shortcut
function Create-Shortcut {
    param (
        [string]$TargetPath,
        [string]$ShortcutPath,
        [string]$Description,
        [string]$Icon
    )
    
    $shortcut = $shell.CreateShortcut($ShortcutPath)
    $shortcut.TargetPath = $TargetPath
    $shortcut.WorkingDirectory = Split-Path $TargetPath
    $shortcut.Description = $Description
    $shortcut.IconLocation = $Icon  # Use custom icon if available
    $shortcut.Save()
    
    Write-Host "Created shortcut: $ShortcutPath" -ForegroundColor Green
}

# Create Desktop shortcut
$desktopShortcut = Join-Path $desktopPath "$appName.lnk"
Create-Shortcut -TargetPath $exePath -ShortcutPath $desktopShortcut -Description "$appName - Desktop Application" -Icon $iconLocation

# Create Start Menu shortcut
$startMenuShortcut = Join-Path $startMenuPath "$appName.lnk"
Create-Shortcut -TargetPath $exePath -ShortcutPath $startMenuShortcut -Description "$appName - Desktop Application" -Icon $iconLocation

Write-Host ""
Write-Host "Shortcuts created successfully!" -ForegroundColor Green
Write-Host "- Desktop: $desktopShortcut" -ForegroundColor Cyan
Write-Host "- Start Menu: $startMenuShortcut" -ForegroundColor Cyan
Write-Host ""
Write-Host "You can now launch the app from Desktop or Start Menu!" -ForegroundColor Yellow

