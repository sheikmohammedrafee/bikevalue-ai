@echo off
title BikeValue AI - Backend (FastAPI)
echo ===================================================
echo   Starting BikeValue AI Backend on Port 8000
echo   API Docs: http://localhost:8000/docs
echo ===================================================
cd /d "%~dp0backend"
call venv\Scripts\activate.bat
python -m uvicorn main:app --reload --port 8000
pause
