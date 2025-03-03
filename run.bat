@echo off
setlocal

:: Définition des variables
set "BUILDTARGET=Build"
set "OUTPUTDIR=Release-windows-x86_64"
set "APP_NAME=DrawPixel"

:: Construction du chemin vers l'exécutable
set "EXECUTABLE=.\%BUILDTARGET%\bin\%OUTPUTDIR%\%APP_NAME%\%APP_NAME%.exe"

:: Vérification de l'existence de l'exécutable
if not exist "%EXECUTABLE%" (
    echo Erreur : L'executable "%EXECUTABLE%" est introuvable.
    exit /b 1
)

:: Exécution de l'application
echo Execution de l'application...
"%EXECUTABLE%"
if %errorlevel% neq 0 (
    echo Erreur lors de l'execution.
    exit /b %errorlevel%
)

echo Programme termine.
exit /b 0
