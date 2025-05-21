#!/usr/bin/env bash

set -e

REPO_NAME=$1

if [[ -z "$REPO_NAME" ]]; then
  echo "Usage: $0 <repo-name>"
  exit 1
fi

echo "Creating monorepo project: $REPO_NAME"

# Setup folder structure
mkdir "$REPO_NAME" && cd "$REPO_NAME"
git init

touch README.md .env

# Create backend UV workspace
uv init --package backend
cd backend
uv add fastapi "uvicorn[standard]" pydantic
uv add --dev pytest ruff poethepoet pyright
# add to the end of pyproject.toml multilines
cat <<'EOT' >> pyproject.toml

[tool.poe.tasks]
# run with eg `uv run poe fmt`
fmt = "ruff format"
lint = "ruff check --fix"
check = "pyright"
test = "pytest"
# run all the above
all = [ {ref="fmt"}, {ref="lint"}, {ref="check"}, {ref="test"} ]

"ci:fmt" = "ruff format --check" # fail if not formatted
"ci:lint" = "ruff check"
EOT
cd ..

mkdir -p backend/tests frontend/

# Create Dockerfile for backend
cat <<EOF > backend/Dockerfile
# Using multi-stage image builds to create a final image without uv. 
# https://github.com/astral-sh/uv-docker-example

# First, build the application in the `/app` directory.
# See `Dockerfile` for details.
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS builder
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

# Disable Python downloads, because we want to use the system interpreter
# across both images. If using a managed Python version, it needs to be
# copied from the build image into the final image; see `standalone.Dockerfile`
# for an example.
ENV UV_PYTHON_DOWNLOADS=0

WORKDIR /app
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-dev
COPY . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-dev


# Then, use a final image without uv
FROM python:3.13-slim-bookworm
# It is important to use the image that matches the builder, as the path to the
# Python executable must be the same, e.g., using `python:3.11-slim-bookworm`
# will fail.

# Copy the application from the builder
COPY --from=builder --chown=app:app /app /app

# Place executables in the environment at the front of the path
ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000

CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

# Create placeholder Dockerfile for frontend
cat <<EOF > frontend/Dockerfile
FROM node:18

WORKDIR /workspace

COPY frontend frontend

WORKDIR /workspace/frontend

RUN npm install || true

EXPOSE 8001

CMD ["npm", "run", "dev"]
EOF

# Compose file with hot reloading and health checks
cat <<EOF > docker-compose.yml
services:
  backend:
    build:
      context: backend
      dockerfile: Dockerfile
    container_name: tradeview-backend
    ports:
      - "8000:8000"
    environment:
      - PYTHONUNBUFFERED=1
    env_file:
      - .env
    volumes:
      - ./backend/src/backend:/workspace/backend/src/backend
      - ./backend/tests:/workspace/backend/tests
    command: ["uvicorn", "backend.server:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--reload-dir", "/workspace/backend/src"]
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/"]
      interval: 30s
      timeout: 10s
      retries: 3

  # frontend:
  #   build:
  #     context: .
  #     dockerfile: frontend/Dockerfile
  #   container_name: tradeview-frontend
  #   ports:
  #     - "8001:8001"
  #   volumes:
  #     - ./frontend/src/frontend:/workspace/frontend/src/frontend
  #   depends_on:
  #     - backend
  #   healthcheck:
  #     test: ["CMD", "curl", "-f", "http://localhost:8001/"]
  #     interval: 30s
  #     timeout: 10s
  #     retries: 3

EOF

# Basic README
cat <<EOF > README.md
# $REPO_NAME

This is a monorepo containing:

- A FastAPI backend using UV and Uvicorn
- A frontend (framework TBD)
- Dockerized dev setup with hot reloading
EOF

echo "✅ Monorepo '$REPO_NAME' setup complete."
