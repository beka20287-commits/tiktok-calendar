@echo off
REM =====================================================
REM TikTok Match Calendar - Build ZIP per Render
REM =====================================================

SET ZIP_NAME=tiktok-calendar.zip

echo.
echo ==============================================
echo TikTok Match Calendar - Creazione archivio ZIP
echo ==============================================
echo.

REM Cancella vecchio archivio se esiste
IF EXIST %ZIP_NAME% (
    echo Rimuovo archivio esistente: %ZIP_NAME%
    del /f %ZIP_NAME%
)

REM Crea struttura cartelle se non esiste
if not exist backend mkdir backend
if not exist backend\migrations mkdir backend\migrations
if not exist frontend mkdir frontend
if not exist frontend\src mkdir frontend\src

REM Copia file principali (sostituisci con i tuoi .js reali se già esistono)
echo Scrivo file backend\server.js
echo // Inserisci qui il contenuto del server.js come già fornito > backend\server.js

echo Scrivo file backend\package.json
echo { "name":"tiktok-calendar-backend","version":"1.0.0" } > backend\package.json

echo Scrivo file backend\Dockerfile
echo FROM node:18-alpine > backend\Dockerfile

echo Scrivo file backend\migrations\init.sql
echo CREATE TABLE IF NOT EXISTS users(...); > backend\migrations\init.sql

echo Scrivo file frontend\package.json
echo { "name":"tiktok-calendar-frontend","version":"1.0.0" } > frontend\package.json

echo Scrivo file frontend\vite.config.js
echo import { defineConfig } from 'vite'; > frontend\vite.config.js

echo Scrivo file frontend\index.html
echo ^<html^>^<body^>^<div id="root"^>App^</div^>^</body^>^</html^> > frontend\index.html

echo Scrivo file frontend\src\App.jsx
echo export default function App(){return ^<h1^>TikTok Calendar^</h1^>} > frontend\src\App.jsx

echo Scrivo file frontend\src\main.jsx
echo import React from "react"; > frontend\src\main.jsx

echo Scrivo render.yaml
echo services: > render.yaml

echo Scrivo .env.example
echo DATABASE_URL=postgresql://postgres:password@localhost:5432/tiktok_calendar > .env.example

REM Comprimi cartella in ZIP (usa PowerShell Compress-Archive)
echo.
echo Creo archivio ZIP: %ZIP_NAME%
powershell -command "Compress-Archive -Path * -DestinationPath %ZIP_NAME% -Force"

echo.
echo ==============================================
echo Archivio creato: %ZIP_NAME%
echo ==============================================
pause