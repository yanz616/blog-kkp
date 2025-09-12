@echo off
echo 🚀 Build Flutter Web...
flutter build web

if %errorlevel% neq 0 (
    echo ❌ Build gagal, periksa error di atas!
    exit /b %errorlevel%
)

echo 🚀 Deploy ke Firebase Hosting...
firebase deploy --only hosting

if %errorlevel% neq 0 (
    echo ❌ Deploy gagal, periksa konfigurasi Firebase!
    exit /b %errorlevel%
)

echo ✅ Selesai! Aplikasi sudah diupdate di Firebase Hosting.
pause
