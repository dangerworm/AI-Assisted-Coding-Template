# /work

This is where project output goes — the thing being built in BUILD mode.

For software projects, suggested conventions (optional):

- `work/backend` — API, workers, jobs
- `work/frontend` — web UI
- `work/infrastructure` — scripts/manifests specific to this project
- `work/terraform` — IaC (if you keep it colocated with the project)

If you use Docker Compose locally, start with `work/docker-compose.yml`.

For environment variables, prefer `.env.example` files and keep `.env` local.
