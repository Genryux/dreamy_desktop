# Dreamy School Management - Desktop Deployment Guide

## Project Structure

```
laravel-electron/
├── main.js                 # Main Electron process
├── config.js              # Configuration file
├── package.json           # Dependencies and build config
├── README.md              # Documentation
├── DEPLOYMENT_GUIDE.md    # This file
├── build/                 # Icon files
└── dist/                  # Built installers (created after build)
```

## Quick Start

### Development Mode
```bash
# Start development (loads http://dreamy.test)
npm run dev
```

### Production Mode (Local Testing)
```bash
# Test production mode (loads your hosted URL)
npm run prod
```

## Building for Distribution

### 1. Update Production URL
Edit `config.js` and replace the production URL:
```javascript
production: {
  url: 'https://your-actual-domain.com', // Replace this!
  name: 'Production Server'
}
```

### 2. Add App Icons (Optional)
Place icon files in `build/` directory:
- `build/icon.ico` (Windows - 256x256px)
- `build/icon.icns` (Mac - 512x512px) 
- `build/icon.png` (Linux - 512x512px)

### 3. Build Installers

#### Windows Only
```bash
npm run build:win
```

#### Mac Only  
```bash
npm run build:mac
```

#### Linux Only
```bash
npm run build:linux
```

#### All Platforms
```bash
npm run build:all
```

### 4. Find Your Installers
After building, check the `dist/` folder:
- **Windows**: `Dreamy School Management Setup 1.0.0.exe`
- **Mac**: `Dreamy School Management-1.0.0.dmg`
- **Linux**: `Dreamy School Management-1.0.0.AppImage`

## Distribution Methods

### Option 1: GitHub Releases (Recommended)
1. Go to your GitHub repository
2. Click "Releases" → "Create a new release"
3. Upload your `.exe` file
4. Add release notes
5. Publish
6. Share the download link

### Option 2: Google Drive / OneDrive
1. Upload installer to cloud storage
2. Set sharing to "Anyone with link"
3. Share download link

### Option 3: Direct File Sharing
1. Copy installer to USB drive
2. Share via email/Teams
3. Upload to school server

## Troubleshooting

### App Won't Start
```bash
# Check if Laravel is running
# Development: http://dreamy.test
# Production: Your hosted URL

# Try different mode
npm run dev    # Development mode
npm run prod   # Production mode
```

### Build Fails
```bash
# Clean and rebuild
npm run clean
npm run build:win

# Check for missing dependencies
npm install
```

## Customization

### Window Size
Edit `config.js`:
```javascript
window: {
  width: 1400,    // Default width
  height: 900,   // Default height
  minWidth: 1200, // Minimum width
  minHeight: 700 // Minimum height
}
```

### App Name
Edit `config.js`:
```javascript
app: {
  name: 'Dreamy School Management',
  version: '1.0.0',
  description: 'Desktop application for Dreamy School Management System'
}
```
## Need Help?

- Check `README.md` for detailed documentation
- Test with `npm run dev` first
- Build with `npm run build:win`
- All commands are in `package.json` scripts
