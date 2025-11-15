const { app, BrowserWindow, dialog, Menu } = require('electron');
const path = require('path');

// Configuration (inline to avoid external file dependency)
const isDev = process.env.NODE_ENV === 'development';
const targetConfig = isDev ? {
  url: 'http://dreamy.test/portal/login',
  name: 'Local Development'
} : {
  url: 'https://dreamyschoolph.site/portal/login',
  name: 'Production'
};

function createWindow() {
  const win = new BrowserWindow({
    width: 1400,
    height: 900,
    minWidth: 1200,
    minHeight: 700,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      enableRemoteModule: false,
      webSecurity: true,
      partition: 'persist:dreamy-desktop' // Isolated session storage
    },
    show: false, // Don't show until ready
    icon: path.join(__dirname, 'build/icon.ico'), // App icon
    title: 'Dreamy School Management'
  });

  // Show window when ready
  win.once('ready-to-show', () => {
    win.show();
  });

  // Determine URL based on environment
  const targetUrl = targetConfig.url;
  
  // Set custom user agent to identify as Electron app
  win.webContents.setUserAgent('DreamyDesktopApp/1.0.0 (Electron)');
  
  // Load your Laravel app
  win.loadURL(targetUrl).catch((err) => {
    console.error('Failed to load Laravel app:', err);
    
    // Show error dialog
    dialog.showErrorBox(
      'Connection Error',
      `Failed to connect to the application server.\n\nPlease check your internet connection and try again.\n\nServer: ${targetConfig.name}\nURL: ${targetUrl}`
    );
  });

  // Handle external links
  win.webContents.setWindowOpenHandler(({ url }) => {
    require('electron').shell.openExternal(url);
    return { action: 'deny' };
  });

  // Handle window closed
  win.on('closed', () => {
    // Dereference the window object
  });

  // Create application menu with session management
  const template = [
    {
      label: 'Session',
      submenu: [
        {
          label: 'Clear Session & Reload',
          click: async () => {
            await win.webContents.session.clearStorageData();
            win.reload();
          }
        },
        {
          label: 'Force Logout',
          click: async () => {
            await win.webContents.session.clearStorageData();
            win.loadURL(targetConfig.url);
          }
        },
        { type: 'separator' },
        {
          label: 'Reload',
          accelerator: 'CmdOrCtrl+R',
          click: () => win.reload()
        }
      ]
    }
  ];

  const menu = Menu.buildFromTemplate(template);
  Menu.setApplicationMenu(menu);
}

// This method will be called when Electron has finished initialization
app.whenReady().then(createWindow);

// Quit when all windows are closed
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});