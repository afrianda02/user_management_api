# User Management (Monorepo)

Backend (Rails API) + Frontend (React/Vite).

## Structure
- `backend/` — Rails API (JWT + OAuth, MySQL, Swagger, Docker)
- `frontend/` — React (Vite + TS)

## Backend
```bash
cd backend
cp .env.example .env
docker compose up --build
```
API: http://localhost:3000  |  Swagger: http://localhost:3000/api-docs

## Frontend
```bash
cd frontend
npm install
npm run dev
```
App: http://localhost:5173
