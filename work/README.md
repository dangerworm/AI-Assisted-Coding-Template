# /app

Put application code here.

Suggested conventions (optional):

- app/backend: API, workers, jobs
- app/frontend: web UI
- app/infrastructure: scripts/manifests specific to this app
- app/terraform: IaC (if you keep it colocated with the app)

If you use Docker Compose locally, start with app/docker-compose.yml.

For environment variables, prefer `.env.example` files and keep `.env` local.
