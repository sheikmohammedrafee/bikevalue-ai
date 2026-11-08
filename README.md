# 🏍️ BikeValue AI — AI-Powered Used Bike Price Estimator

[![Python 3.11](https://img.shields.io/badge/Python-3.11-blue.svg)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.110+-009688.svg)](https://fastapi.tiangolo.com)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-Random--Forest-orange.svg)](https://scikit-learn.org)
[![React 18](https://img.shields.io/badge/React-18.3-61dafb.svg)](https://react.dev)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.6-3178c6.svg)](https://www.typescriptlang.org)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-3.4-38bdf8.svg)](https://tailwindcss.com)

**BikeValue AI** is an end-to-end Machine Learning web application designed to predict the fair market value of second-hand motorcycles and scooters in the Indian market, with localized calibration for **Chennai, Tamil Nadu**.

Built as a Computer Science final-year AI/ML portfolio project featuring:
- **Synthetic Data Engine** generating 700+ realistic Indian two-wheeler transaction samples.
- **Random Forest Regressor** with ColumnTransformer preprocessing (One-Hot Encoding + Standardization).
- **FastAPI REST API** delivering sub-millisecond price ranges, ensemble confidence scores, and analytical factor explanations.
- **Modern React + TypeScript + Tailwind CSS** frontend styled in sleek dark navy blue and vibrant motor-orange.

---

## 📑 Table of Contents
1. [Project Architecture](#-project-architecture)
2. [Input Parameters & AI Outputs](#-input-parameters--ai-outputs)
3. [Folder Structure](#-folder-structure)
4. [Step-by-Step Local Setup](#-step-by-step-local-setup)
5. [Testing the API (cURL & Postman)](#-testing-the-api-curl--postman)
6. [Deployment Guide (Render & Vercel)](#-deployment-guide-render--vercel)
7. [Academic Viva / Defense Q&A](#-academic-viva--defense-qa)

---

## 🏛️ Project Architecture

```
[ User Browser ]
       │
       ▼  HTTP POST /predict (JSON)
[ React + TS Frontend (Vercel) ]
       │
       ▼  CORS REST API
[ FastAPI Backend (Render) ]
       │
       ├─► [ ColumnTransformer Preprocessor (preprocessor.pkl) ]
       │         │ (OneHotEncoder for Brand, Model, Condition, City, etc.)
       │         │ (StandardScaler for Year, Kms Driven)
       │         ▼
       ├─► [ Random Forest Regressor (bike_model.pkl) ]
       │         │ (150 Decision Trees Ensemble)
       │         ▼
       ├─► Tree Variance Estimator ──► Confidence Score (70% - 97%)
       ├─► Deal Evaluator          ──► Verdict (Great Deal / Fair / Overpriced)
       └─► Factor Attribution      ──► Top 3 Price Influencing Factors
```

---

## 🎯 Input Parameters & AI Outputs

### The 9 Input Features:
1. **Brand**: Royal Enfield, Honda, TVS, Bajaj, Yamaha, Hero, KTM, Suzuki
2. **Model**: e.g., Classic 350, Bullet 350, Activa 6G, Pulsar 150, Apache RTR 160, R15 V4, Duke 200, Access 125
3. **Year of Manufacture**: 2010 – 2024
4. **Kilometers Driven**: 0 – 200,000 km
5. **Condition**: Excellent, Good, Average, Poor
6. **Previous Owners**: 1 (Single), 2 (Second-hand), 3+
7. **City**: Chennai, Coimbatore, Bangalore, Mumbai, Delhi
8. **Insurance Valid**: Yes / No
9. **Modifications**: Yes / No
10. *(Optional)* **Seller's Asking Price**: To calculate deal verdict (Great Deal / Fair / Overpriced)

### AI Prediction Outputs:
- **Estimated Fair Price Range**: ₹ Band calculated at $\pm 5.5\%$ (e.g., `₹65,000 – ₹72,000`).
- **Deal Verdict**: Color-coded badge:
  - 🟢 **Great Deal**: Asking price is $\le 92\%$ of fair market value.
  - 🟡 **Fair Deal**: Asking price is within $92\% - 108\%$ of fair value.
  - 🔴 **Overpriced**: Asking price is $> 108\%$ of fair value.
- **Confidence Score**: Derived dynamically from the standard deviation across all 150 trees in the Random Forest.
- **Key Factors**: 3 automated bullet explanations detailing exact ₹ impact of mileage, age depreciation, insurance, and ownership.

---

## 📂 Folder Structure

```
bikevalue-ai/
├── backend/
│   ├── data/
│   │   ├── generate_dataset.py   # Generates realistic synthetic 700-row CSV
│   │   └── bike_data.csv         # Generated dataset of Indian used bikes
│   ├── models/
│   │   ├── bike_model.pkl        # Trained Random Forest Regressor
│   │   ├── preprocessor.pkl      # ColumnTransformer with OneHotEncoder
│   │   └── model_meta.pkl        # Evaluation metrics & metadata
│   ├── main.py                   # FastAPI application with CORS & /predict
│   ├── train_model.py            # Model training & evaluation script
│   ├── requirements.txt          # Python dependencies
│   └── .gitignore
│
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Navbar.tsx        # App bar with live API health indicator
│   │   │   ├── BikeForm.tsx      # Responsive form for all 9 input features
│   │   │   ├── ResultCard.tsx    # Result display card with progress bar
│   │   │   └── MarketInsights.tsx# Chennai market insights & checklist
│   │   ├── types.ts              # TypeScript interfaces
│   │   ├── App.tsx               # Main layout and API state handler
│   │   ├── main.tsx              # React DOM mounting
│   │   └── index.css             # Tailwind base & custom styles
│   ├── index.html
│   ├── package.json
│   ├── tsconfig.json
│   ├── vite.config.ts
│   ├── tailwind.config.js
│   ├── postcss.config.js
│   ├── .env.example
│   └── .gitignore
│
└── README.md
```

---

## 🚀 Step-by-Step Local Setup

### Prerequisites
- Python 3.10+ installed
- Node.js 18+ and npm installed

---

### Step 1: Set Up Backend

1. **Open your terminal and navigate to the backend directory:**
   ```bash
   cd bikevalue-ai/backend
   ```

2. **Create and activate a virtual environment:**
   - **Windows (PowerShell):**
     ```powershell
     python -m venv venv
     .\venv\Scripts\Activate.ps1
     ```
   - **macOS / Linux:**
     ```bash
     python3 -m venv venv
     source venv/bin/activate
     ```

3. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Generate the synthetic dataset (Step 1 of task):**
   ```bash
   python data/generate_dataset.py
   ```
   *Generates `bike_data.csv` with 700 realistic Indian bike records.*

5. **Train the AI Model (Step 2 of task):**
   ```bash
   python train_model.py
   ```
   *Trains the Random Forest Regressor, prints MAE and $R^2$ score ($>85\%$), and outputs `bike_model.pkl` and `preprocessor.pkl` to `models/`.*

6. **Start the FastAPI backend server (Step 3 of task):**
   ```bash
   uvicorn main:app --reload --port 8000
   ```
   *The API will be live at `http://localhost:8000`.*
   *Interactive Swagger API Docs available at `http://localhost:8000/docs`.*

---

### Step 2: Set Up Frontend

1. **Open a new terminal and navigate to the frontend directory:**
   ```bash
   cd bikevalue-ai/frontend
   ```

2. **Install Node dependencies:**
   ```bash
   npm install
   ```

3. **Ensure environment variable points to local backend:**
   Create `.env` file (if not present):
   ```env
   VITE_API_URL=http://localhost:8000
   ```

4. **Start the React development server:**
   ```bash
   npm run dev
   ```
   *The frontend will open at `http://localhost:5173`.*

---

## 🧪 Testing the API (cURL & Postman)

### 1. Health Check
```bash
curl -X GET http://localhost:8000/health
```
**Expected Response:**
```json
{
  "status": "healthy",
  "service": "BikeValue AI Backend",
  "model_loaded": true,
  "preprocessor_loaded": true
}
```

### 2. Predict Price (cURL Command)
```bash
curl -X POST http://localhost:8000/predict \
  -H "Content-Type: application/json" \
  -d '{
    "brand": "Royal Enfield",
    "model": "Classic 350",
    "year": 2021,
    "kms_driven": 18000,
    "condition": "Good",
    "owners": "1",
    "city": "Chennai",
    "insurance": "Yes",
    "modifications": "No",
    "asking_price": 140000
  }'
```

**Sample API JSON Response:**
```json
{
  "predicted_price": 163000,
  "price_range_low": 154000,
  "price_range_high": 172000,
  "price_range_formatted": "₹154,000 – ₹172,000",
  "verdict": "Great Deal",
  "verdict_badge_color": "green",
  "confidence_score": 87,
  "key_factors": [
    "Standard 'Good' condition matches healthy secondary market expectations.",
    "Kilometers driven (18,000 km) is well within normal city commuter norms.",
    "First-hand (Single Owner) status commands peak buyer confidence and liquidity."
  ],
  "model_metrics": {
    "r2_score": 0.8528,
    "mae_inr": 15436.79,
    "algorithm": "Random Forest Regressor (150 Estimators)"
  }
}
```

---

## 🌐 Deployment Guide (Render & Vercel)

### Step 1: Push Project to GitHub
1. Create a new GitHub repository called `bikevalue-ai`.
2. Push your code:
   ```bash
   cd bikevalue-ai
   git init
   git add .
   git commit -m "Initial commit of BikeValue AI"
   git branch -M main
   git remote add origin https://github.com/<your-username>/bikevalue-ai.git
   git push -u origin main
   ```

---

### Step 2: Deploy Backend to Render (Free Tier)
1. Go to [Render.com](https://render.com) and log in with GitHub.
2. Click **New +** ➔ **Web Service**.
3. Select your `bikevalue-ai` repository.
4. Fill in the settings:
   - **Name**: `bikevalue-ai-backend`
   - **Root Directory**: `backend`
   - **Environment**: `Python 3`
   - **Build Command**: 
     ```bash
     pip install -r requirements.txt && python data/generate_dataset.py && python train_model.py
     ```
     *(This ensures the dataset and `.pkl` models are generated automatically during build!)*
   - **Start Command**: 
     ```bash
     uvicorn main:app --host 0.0.0.0 --port $PORT
     ```
   - **Plan**: `Free`
5. Click **Create Web Service**.
6. Wait for the build to finish. Copy your live Render URL (e.g., `https://bikevalue-ai-backend.onrender.com`).

---

### Step 3: Deploy Frontend to Vercel (Free Tier)
1. Go to [Vercel.com](https://vercel.com) and log in with GitHub.
2. Click **Add New...** ➔ **Project**.
3. Import your `bikevalue-ai` repository.
4. Configure the project:
   - **Framework Preset**: `Vite`
   - **Root Directory**: Click edit and select `frontend`
5. Under **Environment Variables**, add:
   - **Key**: `VITE_API_URL`
   - **Value**: `https://bikevalue-ai-backend.onrender.com` *(your live Render URL without trailing slash)*
6. Click **Deploy**.
7. In ~60 seconds, your frontend will be live on a `.vercel.app` URL!

---

## 🎓 Academic Viva / Defense Q&A

When presenting this project to your college professors or external examiners, here are the top questions they will ask:

#### Q1: Why did you choose Random Forest Regressor over Linear Regression or Deep Learning?
> **Answer**: Used bike pricing is fundamentally non-linear. Depreciation drops sharply in Year 1 (~15%) and flattens later. Furthermore, features interact strongly (e.g., high KMs matter much more on a 2-year-old sports bike than an 8-year-old commuter). Random Forest handles non-linearities and feature interactions naturally without overfitting, unlike Linear Regression. Deep Neural Networks require tens of thousands of data points; with 700 samples, Random Forest is the mathematically sound and optimal choice.

#### Q2: How did you handle categorical variables in the ML pipeline?
> **Answer**: We used `ColumnTransformer` from `scikit-learn` with `OneHotEncoder(handle_unknown='ignore')` for nominal features (`brand`, `model`, `condition`, `city`, `insurance`, `modifications`). We paired it with `StandardScaler` on numerical features (`year`, `kms_driven`). The fitted preprocessor is serialized with `joblib` so inference always uses identical one-hot schema.

#### Q3: How is the confidence score calculated?
> **Answer**: Unlike arbitrary numbers, our confidence score is derived from the **ensemble variance**. Because Random Forest is composed of 150 individual decision trees, we compute the standard deviation and coefficient of variation ($CV = \frac{\sigma}{\mu}$) across all 150 predictions. When the trees agree closely, $CV$ is low, indicating high model confidence ($85\% - 96\%$).

#### Q4: How is Chennai market context represented in the model?
> **Answer**: Chennai is prioritized in dataset sampling weight (45% of listings), with regional market price multipliers and depreciation rules that model local commuter demand for models like Honda Activa, TVS Jupiter, and Royal Enfield Classic 350.
