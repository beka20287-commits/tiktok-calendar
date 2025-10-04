@echo off
SET ZIP_NAME=tiktok-calendar.zip
SET REPO_URL=https://github.com/beka20287-commits/tiktok-calendar.git
SET BRANCH=main

echo.
echo ===========================================
echo TikTok Match Calendar - ZIP + GitHub Push
echo ===========================================
echo.

REM Controllo PowerShell
where powershell >nul 2>&1
IF ERRORLEVEL 1 (
    echo Errore: PowerShell non trovato.
    pause
    exit /b
)

REM 1️⃣ Crea ZIP del progetto
IF EXIST %ZIP_NAME% (
    echo Rimuovo vecchio archivio: %ZIP_NAME%
    del /f %ZIP_NAME%
)
echo Creo ZIP del progetto...
powershell -command "Compress-Archive -Path * -DestinationPath %ZIP_NAME% -Force"

echo.
echo ===========================================
echo Archivio creato: %ZIP_NAME%
echo ===========================================

REM 2️⃣ Inizializza Git se non esiste
git rev-parse --is-inside-work-tree >nul 2>&1
IF ERRORLEVEL 1 (
    echo Inizializzo repository Git locale...
    git init
    git remote add origin %REPO_URL%
) ELSE (
    echo Repository Git già inizializzato.
)

REM 3️⃣ Aggiunge tutti i file
git add .

REM 4️⃣ Commit
git commit -m "Deploy progetto TikTok Calendar"

REM 5️⃣ Push
echo Eseguo push su GitHub (%BRANCH%)...
git push -u origin %BRANCH%

echo.
echo ===========================================
echo ✅ Deploy completato!
echo ===========================================
pause
