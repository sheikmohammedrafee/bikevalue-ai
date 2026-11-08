@echo off
title BikeValue AI - Frontend (React + Vite)
echo ===================================================
echo   Starting BikeValue AI Frontend on Port 5173
echo   Web UI: http://localhost:5173
echo ===================================================
cd /d "%~dp0frontend"
call npm.cmd run dev
pause
