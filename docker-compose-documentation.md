# Docker Compose Configuration Documentation

This documentation provides a detailed explanation of the `docker-compose.yaml` file for the PostgreSQL and pgAdmin demo setup.

---

## Version
```yaml
version: "3.9"
```
Specifies the Docker Compose file format version.

---

## Services

### 1. **demo-cluster-00**
This service sets up a PostgreSQL database instance.

#### Configuration
- **Image**: `postgres`
  - Uses the official PostgreSQL Docker image.
- **Container Name**: `demo-cluster-00`
  - The container will be named `demo-cluster-00`.
- **User**: `1001:1001`
  - Runs the container as the user with UID and GID `1001`.
- **Restart Policy**: `always`
  - Ensures the container restarts automatically if it stops.
- **Ports**:
  - Maps port `5555` on the host to port `5432` in the container (PostgreSQL default port).
- **Command**:
  - Configures the PostgreSQL server with the following settings:
    - `shared_preload_libraries`: Includes `auto_explain` and `pg_stat_statements`.
    - `pg_stat_statements.track`: Tracks all queries.
    - `max_connections`: Sets a maximum of 200 connections.
- **Environment Variables**:
  - `POSTGRES_USER_PWD_FILE`: Path to the secret file containing the database user password.
  - `POSTGRES_USER_PWD_FILE`: Path to the secret file containing the database password.
- **Volumes**:
  - `./data/:/var/lib/postgresql/data`: Mounts the local `data` directory to PostgreSQL's data directory.
  - `./temp/:/tmp/`: Mounts the local `temp` directory to the container's `/tmp/` directory.
- **Networks**:
  - `db_demo_net`: Attaches the container to a custom network with the IP address `175.20.0.6`.
- **Healthcheck**:
  - Verifies container health by running `pg_isready`.
  - **Interval**: Every 2 seconds.
  - **Timeout**: 10 seconds.
  - **Retries**: 10 attempts.
  - **Start Period**: 30 seconds.
- **Secrets**:
  - `db-user-secret`: Includes the database user secret.
  - `db-password-secret`: Includes the database password secret.

---

### 2. **pgadmin**
This service sets up pgAdmin, a web-based PostgreSQL management tool.

#### Configuration
- **Image**: `dpage/pgadmin4`
  - Uses the official pgAdmin Docker image.
- **Container Name**: `demo-pgadmin`
  - The container will be named `demo-pgadmin`.
- **Restart Policy**: `always`
  - Ensures the container restarts automatically if it stops.
- **Ports**:
  - Maps port `9999` on the host to port `80` in the container (pgAdmin's default port).
- **Environment Variables**:
  - `PGADMIN_DEFAULT_EMAIL`: Default admin email for pgAdmin (`s@khromoy.net`).
  - `PGADMIN_DEFAULT_PASSWORD_FILE`: Path to the secret file containing the pgAdmin password.
- **Volumes**:
  - `./pgadmin-data/:/var/lib/pgadmin`: Mounts the local `pgadmin-data` directory to pgAdmin's data directory.
- **Networks**:
  - `db_demo_net`: Attaches the container to a custom network with the IP address `175.20.0.2`.
- **Healthcheck**:
  - Verifies container health by sending an HTTP request to `http://localhost:80/misc/ping`.
  - **Interval**: Every 10 seconds.
  - **Timeout**: 10 seconds.
  - **Start Period**: 160 seconds.
  - **Retries**: 3 attempts.
- **Secrets**:
  - `pgadmin_pwd_secret`: Includes the pgAdmin password secret.

---

## Networks

### db_demo_net
A custom Docker network for the PostgreSQL and pgAdmin services.

- **Driver**: `default`
- **Subnet**: `175.20.0.0/24`

---

## Secrets

Secrets are used to securely provide sensitive information to the containers.

### 1. **db-user-secret**
- **File**: `./secrets/db_user.txt`
  - Contains the database user credentials.

### 2. **db-password-secret**
- **File**: `./secrets/db_password.txt`
  - Contains the database password.

### 3. **pgadmin_pwd_secret**
- **File**: `./secrets/pgadmin_passwd.txt`
  - Contains the pgAdmin default password.

---

## Summary
This `docker-compose.yaml` file defines a simple PostgreSQL cluster and a web-based management interface (pgAdmin). It integrates secrets for secure credential management, health checks for monitoring service availability, and custom network configurations for controlled communication between services.