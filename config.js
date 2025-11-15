// Configuration for Dreamy School Management Desktop App

module.exports = {
  // Environment detection
  isDev: process.env.NODE_ENV === 'development',
  
  // URLs
  production: {
    url: 'https://your-dreamy-app.com/portal/login', // Replace with your actual URL
    name: 'Production Server'
  },
  
  development: {
    url: 'http://dreamy.test/portal/login',
    name: 'Local Development'
  },
  
  // App settings
  app: {
    name: 'Dreamy School Management',
    version: '1.0.0',
    description: 'Desktop application for Dreamy School Management System'
  },
  
  // Window settings
  window: {
    width: 1400,
    height: 900,
    minWidth: 1200,
    minHeight: 700
  }
};
