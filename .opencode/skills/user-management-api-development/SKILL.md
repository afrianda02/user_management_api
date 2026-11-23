---
name: user-management-api-development
description: Guidelines and conventions for developing, modifying, and testing the User Management API Ruby on Rails project (JWT + OAuth, MySQL, Swagger, Docker).
---

# User Management API Development Skill

This skill provides domain-specific guidelines, architecture rules, and testing standards for working with the User Management API Rails project.

## Tech Stack

- **Framework**: Ruby on Rails 7.1 (API-only)
- **Language**: Ruby
- **Database**: MySQL (configured in `config/database.yml`)
- **Auth**: Devise + JWT (devise-jwt) + OAuth (OmniAuth: Google, GitHub)
- **Docs**: RSwag (Swagger UI at `/api-docs`)
- **Container**: Docker + docker-compose
- **Tests**: RSpec (`spec/`)

## Project Structure

- `app/controllers/api/v1/` — API controllers (`auth_controller`, `users_controller`, `oauth_callbacks_controller`)
- `app/models/` — ActiveRecord models (`user`, `refresh_token`, `jwt_denylist`)
- `app/services/` — Services (`jwt_service`)
- `config/routes.rb` — Routes
- `db/migrate/` — Migrations
- `db/schema.rb` — Schema
- `spec/` — RSpec tests (`requests/`, `factories/`, `support/`)
- `config/initializers/` — Devise, CORS, RSwag config

## Coding Conventions

1. **API-only**: No views; controllers render JSON.
2. **Namespacing**: All API endpoints under `Api::V1`.
3. **Auth**: JWT access tokens + refresh tokens; logout adds token to `JwtDenylist`.
4. **Soft delete**: Users use `deleted_at` (scope `active`).
5. **Roles**: `user` (0) / `admin` (1) enum.
6. **OAuth**: Providers google_oauth2, github; callback route `/auth/:provider/callback`.

## Endpoints

- POST /api/v1/auth/register
- POST /api/v1/auth/login
- POST /api/v1/auth/refresh
- DELETE /api/v1/auth/logout
- GET /api/v1/auth/me
- GET /api/v1/users
- GET /api/v1/users/:id
- PATCH /api/v1/users/:id
- DELETE /api/v1/users/:id
- GET /auth/:provider/callback

## Running

- Docker: `cp .env.example .env && docker compose up --build`
- API: http://localhost:3000
- Swagger UI: http://localhost:3000/api-docs

## Testing

- Run RSpec: `bundle exec rspec`
- Factories in `spec/factories/`
- Auth helper in `spec/support/auth_helper.rb`

## Hardening Roadmap (TODO)

- [Auth] Restrict create/update/destroy to admin role
- [Pagination] Add page/per_page + meta
- [Search] Filter JobCategory by name
- [Response] Standardize JSON envelope (data + meta)
- [Errors] Unified error rendering
- [Tests] Request specs for roles/pagination
- [Swagger] Document params & responses
