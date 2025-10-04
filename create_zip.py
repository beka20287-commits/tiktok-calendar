import os
import zipfile

# Nome dell'archivio
zip_name = "tiktok-calendar.zip"

# Struttura cartelle e file da creare
project_structure = {
    "backend": {
        "server.js": "// Contenuto server.js",
        "package.json": "{ \"name\": \"tiktok-calendar-backend\", \"version\": \"1.0.0\" }",
        "Dockerfile": "FROM node:18-alpine\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install --production\nCOPY . .\nEXPOSE 4000\nCMD [\"npm\",\"start\"]",
        "migrations/init.sql": "-- SQL iniziale"
    },
    "frontend": {
        "index.html": "<!DOCTYPE html><html><body><div id='root'></div></body></html>",
        "package.json": "{ \"name\": \"tiktok-calendar-frontend\", \"version\": \"1.0.0\" }",
        "vite.config.js": "import { defineConfig } from 'vite'; export default defineConfig({})",
        "Dockerfile": "FROM node:18-alpine as build\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install\nCOPY . .\nRUN npm run build\nFROM nginx:alpine\nCOPY --from=build /app/dist /usr/share/nginx/html\nEXPOSE 80\nCMD [\"nginx\",\"-g\",\"daemon off;\"]",
        "nginx.conf": "server { listen 80; root /usr/share/nginx/html; index index.html; location / { try_files $uri /index.html; } }",
        "src/App.jsx": "export default function App(){ return <h1>TikTok Calendar</h1>; }"
    },
    "render.yaml": "services: []",
    ".env.example": "DATABASE_URL=postgres://postgres:password@localhost:5432/tiktok_calendar\nJWT_SECRET=supersecret\nNODE_ENV=production"
}

# Funzione per aggiungere i file allo ZIP
def add_files(zipf, folder, files):
    for name, content in files.items():
        path = os.path.join(folder, name)
        if isinstance(content, dict):
            # È una cartella
            add_files(zipf, path, content)
        else:
            # È un file
            zipf.writestr(path, content)

# Crea lo ZIP
with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
    add_files(zipf, "", project_structure)

print(f"✅ Archivio creato: {zip_name}")
