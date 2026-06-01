@echo off
setlocal

:: Dossier principal
set "NG_DIR=%USERPROFILE%\NationsGlory"
mkdir "%NG_DIR%" 2>nul

cd /d "%NG_DIR%"

:: Téléchargement
powershell -Command "Invoke-WebRequest -Uri 'https://nationsglory.fr/download?windows' -OutFile 'NationsGloryInstaller.exe'"

:: Lancement sans demande d'élévation
set __COMPAT_LAYER=RunAsInvoker
start "" "NationsGloryInstaller.exe"

echo Attente de la creation du dossier NG...

:WAIT_NG
if exist "%NG_DIR%\NG" goto NG_FOUND
timeout /t 5 >nul
goto WAIT_NG

:NG_FOUND
echo Dossier NG detecte.

echo Attente de NationsGlory.exe...

:WAIT_EXE
if exist "%NG_DIR%\NG\NationsGlory.exe" goto EXE_FOUND
timeout /t 5 >nul
goto WAIT_EXE

:EXE_FOUND
echo Executable detecte.

:: Creation du raccourci Bureau
powershell -NoProfile -ExecutionPolicy Bypass -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\NationsGlory.lnk');$s.TargetPath='%NG_DIR%\NG\NationsGlory.exe';$s.WorkingDirectory='%NG_DIR%\NG';$s.Save()"

echo Raccourci cree sur le Bureau.
echo Termine.

pause
