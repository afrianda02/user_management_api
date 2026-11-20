# User Management API

Backend RESTful API dengan Ruby on Rails (API-only), MySQL, JWT + OAuth, Swagger, Docker, dan CI/CD.

## Menjalankan dengan Docker

```bash
cp .env.example .env
docker compose up --build
```

API: http://localhost:3000
Swagger UI: http://localhost:3000/api-docs

## Endpoint Utama

- POST /api/v1/auth/register
- POST /api/v1/auth/login
- POST /api/v1/auth/refresh
- DELETE /api/v1/auth/logout
- GET /api/v1/auth/me
- GET /api/v1/users
- GET /api/v1/users/:id
- PATCH /api/v1/users/:id
- DELETE /api/v1/users/:id
- GET /auth/:provider/callback (google, github)