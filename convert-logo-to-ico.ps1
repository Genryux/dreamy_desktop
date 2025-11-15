# PowerShell script to convert PNG logo to ICO format for Windows
# This script helps convert your school logo to an icon file

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$logoPath = Join-Path $scriptPath "build\logo.png"
$iconPath = Join-Path $scriptPath "build\icon.ico"

Write-Host "=== Dreamy School Management - Logo to Icon Converter ===" -ForegroundColor Cyan
Write-Host ""

# Check if logo.png exists
if (-not (Test-Path $logoPath)) {
    Write-Host "Error: logo.png not found at $logoPath" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please copy your school logo to: build\logo.png" -ForegroundColor Yellow
    Write-Host "Or use one of these logos from your Laravel project:" -ForegroundColor Yellow
    Write-Host "  - public\images\Dreamy_logo.png" -ForegroundColor Gray
    Write-Host "  - public\images\systemicon.png" -ForegroundColor Gray
    exit 1
}

Write-Host "Found logo: $logoPath" -ForegroundColor Green

# Method 1: Try using online conversion
Write-Host ""
Write-Host "To convert PNG to ICO format, you have these options:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Option 1: Online Converter (Recommended)" -ForegroundColor Cyan
Write-Host "  1. Go to: https://icoconvert.com/ or https://convertio.co/png-ico/" -ForegroundColor White
Write-Host "  2. Upload: build\logo.png" -ForegroundColor White
Write-Host "  3. Convert and download as: icon.ico" -ForegroundColor White
Write-Host "  4. Save to: build\icon.ico" -ForegroundColor White
Write-Host ""
Write-Host "Option 2: Using ImageMagick (if installed)" -ForegroundColor Cyan
Write-Host "  Run: magick convert build\logo.png -define icon:auto-resize=256,128,64,48,32,16 build\icon.ico" -ForegroundColor White
Write-Host ""

# Try using .NET System.Drawing if available
try {
    Add-Type -AssemblyName System.Drawing
    $bitmap = New-Object System.Drawing.Bitmap($logoPath)
    
    Write-Host "Attempting to create ICO file..." -ForegroundColor Yellow
    
    # Create a simple ICO file (Windows will resize automatically)
    # Note: ICO files can contain multiple sizes, but for simplicity, we'll create a basic one
    $icon = [System.Drawing.Icon]::FromHandle($bitmap.GetHicon())
    
    # Save as ICO (Windows method)
    $stream = [System.IO.File]::Create($iconPath)
    $icon.Save($stream)
    $stream.Close()
    $icon.Dispose()
    $bitmap.Dispose()
    
    if (Test-Path $iconPath) {
        Write-Host "Success! Created icon.ico at: $iconPath" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor Cyan
        Write-Host "  1. Rebuild the app: npm run build:win" -ForegroundColor White
        Write-Host "  2. Create shortcuts: npm run create-shortcuts" -ForegroundColor White
        exit 0
    }
} catch {
    Write-Host "Automatic conversion failed: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Please use Option 1 (Online Converter) to convert your logo." -ForegroundColor Yellow
Write-Host "After conversion, save the file as: build\icon.ico" -ForegroundColor Yellow

