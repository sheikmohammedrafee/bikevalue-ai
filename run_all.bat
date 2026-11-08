@echo off
title BikeValue AI - Full Stack Launcher
echo ===================================================
echo   Launching BikeValue AI (Backend + Frontend)
echo ===================================================
start "BikeValue AI Backend" cmd /k "cd /d %~dp0backend && call venv\Scripts\activate.bat && python -m uvicorn main:app --reload --port 8000"
timeout /t 2 /nobreak >nul
start "BikeValue AI Frontend" cmd /k "cd /d %~dp0frontend && call npm.cmd run dev"
echo.
echo Both servers started!
echo Backend:  http://localhost:8000/docs
echo Frontend: http://localhost:5173
echo.
pause
