# PostgreSQL and pgAdmin Docker Stack

This repository contains a Docker Compose configuration to launch a PostgreSQL database and a pgAdmin instance for database management.

---

## Prerequisites

Ensure the following are installed on your system:
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

---

## Instructions to Launch the Stack

### 1. Clone the Repository
Clone this repository to your local machine:
```bash
git clone https://github.com/sk-at-redgate/pgsql-docker-demo.git
cd pgsql-docker-demo
```

### 2. Prepare the Directory Structure
In the root directory of the repository, execute the following commands to create necessary directories and set permissions:

```bash
# Create required directories
mkdir -v {data,pgadmin-data,secrets,temp}
mkdir -v pgadmin-data/{azurecredentialcache,sessions,storage}

# Set ownership for pgAdmin data directory
chown -R 5050:5050 pgadmin-data

# Set ownership for PostgreSQL data directory
chown -R 1001:1001 data
```

---

### 3. Add Secrets Files
Create the following secret files in the `secrets` directory as referenced in the `docker-compose.yaml` file:

- **Database User Secret**
  - Path: `secrets/db_user.txt`
  - Content: Add the database user name here.

- **Database Password Secret**
  - Path: `secrets/db_password.txt`
  - Content: Add the database password here.

- **pgAdmin Password Secret**
  - Path: `secrets/pgadmin_passwd.txt`
  - Content: Add the default password for pgAdmin here.


---

### 4. Start and Stop the Stack

#### To Start
Run the following command in the root directory of the repository:
```bash
docker-compose up -d
```

#### To Stop
Run the following command:
```bash
docker-compose down
```

---

## Configuration Details

### PostgreSQL Service (`demo-cluster-00`)
- **Image**: Official PostgreSQL image.
- **Ports**: Host `5555` → Container `5432`.
- **Data Directory**: `data/` (local) → `/var/lib/postgresql/data` (container).
- **Temporary Directory**: `temp/` (local) → `/tmp/` (container).
- **Secrets**:
  - `db-user-secret`: User credentials.
  - `db-password-secret`: Password credentials.
- **Network**: Custom network with IP `175.20.0.6`.

### pgAdmin Service (`pgadmin`)
- **Image**: Official pgAdmin image.
- **Ports**: Host `9999` → Container `80`.
- **Data Directory**: `pgadmin-data/` (local) → `/var/lib/pgadmin` (container).
- **Secrets**:
  - `pgadmin_pwd_secret`: Default password.
- **Network**: Custom network with IP `175.20.0.2`.

---

## Health Checks
Both services include health checks to ensure proper functioning:
- PostgreSQL: Uses `pg_isready`.
- pgAdmin: Uses an HTTP ping to `http://localhost:80/misc/ping`.

---

## Network Configuration
A custom Docker network (`db_demo_net`) is used with the following subnet:
```yaml
subnet: '175.20.0.0/24'
```

---

For more details, refer to the [docker-compose.yaml](./docker-compose.yaml) file.

For more details, refer to the [docker-compose.yaml.documentation](./docker-compose-documentation.md) file.





