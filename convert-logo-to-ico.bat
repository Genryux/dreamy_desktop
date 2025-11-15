@echo off
REM Batch file to convert PNG logo to ICO format
REM Simply double-click this file to run the conversion script

powershell -ExecutionPolicy Bypass -File "%~dp0convert-logo-to-ico.ps1"

pause

