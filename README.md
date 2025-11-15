# Dreamy School Management - Desktop App

This is the desktop version of the Dreamy School Management system, built with Electron.

## Development

### Prerequisites
- Node.js (v16 or higher)
- Your Laravel app running locally at `http://dreamy.test`

### Setup
1. Install dependencies:
   ```bash
   npm install
   ```

2. Start development:
   ```bash
   npm run dev
   ```

## Building for Production

### 1. Update Production URL
Edit `main.js` and replace `https://your-dreamy-app.com` with your actual hosted URL.

### 2. Add Custom App Icon (School Logo)
The app uses your custom school logo as the icon for the executable and shortcuts.

**Quick Setup:**
1. Copy your school logo PNG to `build/logo.png` (or it's already there from your Laravel project)
2. Convert PNG to ICO format:
   ```bash
   # Option 1: Double-click this file
   convert-logo-to-ico.bat
   
   # Option 2: Run PowerShell script
   powershell -ExecutionPolicy Bypass -File convert-logo-to-ico.ps1
   
   # Option 3: Use online converter (recommended)
   # Visit: https://icoconvert.com/
   # Upload: build\logo.png
   # Download and save as: build\icon.ico
   ```

3. **Result:** The `build/icon.ico` file will be used for:
   - The executable icon (when building)
   - Desktop shortcut icon
   - Start Menu shortcut icon
   - Window icon (when app is running)

**Icon Requirements:**
- Format: `.ico` for Windows
- Recommended size: 256x256px (will be auto-resized)
- Location: `build/icon.ico`

**Available logos from Laravel project:**
- `public/images/Dreamy_logo.png`
- `public/images/systemicon.png`

### 3. Build Portable Executable
```bash
# Build for Windows (creates portable .exe)
npm run build:win

# Build for Mac
npm run build:mac

# Build for Linux
npm run build:linux

# Build for all platforms
npm run build
```

### 4. Distribution
The built executable will be in the `dist/` folder:
- Windows: `Dreamy School Management 1.0.0.exe` (Portable)
- Mac: `Dreamy School Management-1.0.0.dmg`
- Linux: `Dreamy School Management-1.0.0.AppImage`

**For Windows:** Users just need to:
1. Download the `.exe` file
2. Double-click to run (portable - no installation needed)

## Configuration

### Environment
- Development: Uses `http://dreamy.test`
- Production: Uses your hosted URL

### Window Settings
- Default size: 1400x900
- Minimum size: 1200x700
- Resizable: Yes
- Fullscreen: Supported

## Troubleshooting

### App won't start
1. Check if your Laravel app is running
2. Verify the URL in `main.js`
3. Check console for errors

### Build fails
1. Make sure all dependencies are installed: `npm install`
2. Check if icon files exist in `build/` directory
3. Try building for specific platform: `npm run build:win`

### External links
External links automatically open in the default browser.

## Deployment

1. Build the installer: `npm run build:win`
2. Upload to GitHub Releases or file sharing service
3. Share download link with users
4. Users download and install like any Windows app

## File Structure

```
laravel-electron/
├── main.js                    # Main Electron process
├── config.js                  # Application configuration
├── package.json               # Dependencies and build config
├── convert-logo-to-ico.ps1   # PowerShell script to convert PNG to ICO
├── convert-logo-to-ico.bat    # Batch script to convert logo (double-click to run)
├── README.md                  # This file
├── DEPLOYMENT_GUIDE.md        # Detailed deployment instructions
├── build/                     # Icon files
│   ├── logo.png              # School logo (PNG source)
│   ├── icon.ico              # Windows icon (converted from logo.png)
│   ├── icon.icns             # Mac icon
│   └── icon.png              # Linux icon
└── dist/                      # Built executables (created after build)
    └── Dreamy School Management 1.0.0.exe  # Portable executable
```

## Installation Process

### For Developers:
1. **Build the executable:**
   ```bash
   npm run build:win
   ```

2. **Result:**
   - Executable: `dist\Dreamy School Management 1.0.0.exe`
   - Portable - no installation needed

### For End Users:
1. **Download:**
   - `Dreamy School Management 1.0.0.exe` (from dist folder)

2. **Run:**
   - Double-click the `.exe` file to run
   - No installation required - just run it!

**That's it!** Simple portable executable - no installer complexity.
