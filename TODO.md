# TODO - User Management API

## Backend Hardening
- [ ] [Auth] Restrict create/update/delete JobCategory to admin role
- [ ] [Pagination] Add page/per_page + meta response
- [ ] [Search] Filter JobCategory by name query param
- [ ] [Response] Standardize JSON envelope (data + meta)
- [ ] [Errors] Unified error rendering
- [ ] [Tests] Request specs for roles/pagination
- [ ] [Swagger] Document params & responses

## Files
- Model: backend/app/models/job_category.rb
- Controller: backend/app/controllers/api/v1/job_categories_controller.rb
- Routes: backend/config/routes.rb
- Swagger: backend/swagger/v1/swagger.yaml
- Frontend API: frontend/src/api.ts
- Frontend UI: frontend/src/App.tsx
- Skill: .opencode/skills/user-management-api-development/SKILL.md
