# Portainer CE - Docker Compose

Minimal compose to run [Portainer CE](https://www.portainer.io/) with full Docker daemon access (manage containers, images, networks, volumes, logs, exec).

## Prerequisites

- Docker Engine `>= 20.10` and Docker Compose `v2` (`docker compose version`)
- External network for HTTPS/reverse proxy:
  ```bash
  docker network create https_network
  ```

## Quick Start

### 1. Create env file
```bash
cp .env.example .env
```

### 2. Configure environment
Edit `.env` and set all required variables:
- `EDGE_PORT` / `HTTP_PORT` / `HTTPS_PORT` – host ports
- `HTTPS_NETWORK` – external Docker network name
- `ADMIN_PASSWORD` – initial `admin` password

### 3. Create external network (if not exists)
```bash
docker network create https_network
# verify
docker network ls | grep https_network
```

### 4. Start Portainer
```bash
docker compose up -d
```

### 5. Verify
```bash
docker compose ps
docker compose logs -f          # follow logs until healthy
curl -ks https://localhost:9443 | head   # should return HTML 200
```

### 6. Open UI
- https://localhost:9443 (HTTPS, self-signed) – `HTTPS_PORT`
- http://localhost:9000 (HTTP) – `HTTP_PORT`

Default login: `admin` / value of `ADMIN_PASSWORD` from `.env`.

> `ADMIN_PASSWORD` is only used on **first init** when `portainer_data` volume is empty. Changing it later does not rotate the password – reset via UI (`Users` → `admin`) or wipe volume:
> ```bash
> docker compose down -v   # deletes portainer_data + portainer_pwd – data loss
> ```

## Environment Variables

All ports and the network are **required** (no defaults – compose fails without `.env`).

| Variable | Description | Example |
|----------|-------------|---------|
| `EDGE_PORT` | Host port for Edge Agent (`8000` in container) | `8001` (avoids host `8000` conflict) |
| `HTTP_PORT` | Host port for HTTP UI (`9000`) | `9000` |
| `HTTPS_PORT` | Host port for HTTPS UI (`9443`) | `9443` |
| `HTTPS_NETWORK` | External Docker network name (`external: true`) | `https_network` |
| `ADMIN_PASSWORD` | Plaintext `admin` password for first init | `changeme123` |

## Authors

- **Adi Sabyrbayev** — [@madrigals1](https://github.com/madrigals1) — Initial work & maintainer
