# Installation Overview

This guide summarizes the steps required to spin up the Memoro-inspired platform locally. Detailed automation scripts will be provided in future iterations.

## Prerequisites

- Node.js 18+
- Python 3.11+
- PostgreSQL 14+
- Yarn or npm
- Git

## 1. Clone the Repository

```bash
git clone <repository-url>
cd memoro-platform
```

## 2. Configure the Database

1. Create a PostgreSQL database:
   ```sql
   CREATE DATABASE memoro_platform;
   ```
2. Enable the `pgcrypto` extension for UUID generation:
   ```sql
   CREATE EXTENSION IF NOT EXISTS pgcrypto;
   ```
3. Apply the schema:
   ```bash
   psql -d memoro_platform -f database/schema.sql
   ```

## 3. Backend Environment

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Create a Python virtual environment (FastAPI) or configure Node.js dependencies (Express). Both templates will be published shortly.
3. Copy `.env.example` to `.env` and set:
   ```env
   DATABASE_URL=postgresql+psycopg://user:password@localhost:5432/memoro_platform
   JWT_SECRET="change-me"
   ADMIN_EMAIL=research@study.org
   ```
4. Run the development server (placeholder command):
   ```bash
   uvicorn app.main:app --reload
   ```

## 4. Frontend Environment

1. Navigate to the frontend directory:
   ```bash
   cd ../frontend
   ```
2. Install dependencies (once scaffolding is added):
   ```bash
   npm install
   npm run dev
   ```

## 5. Admin Dashboard

The admin interface will be implemented as a separate React application served behind researcher authentication. Stay tuned for setup instructions.

## 6. Environment Variables Summary

| Variable | Description |
|----------|-------------|
| `DATABASE_URL` | PostgreSQL connection string with credentials |
| `JWT_SECRET` | Secret key for signing backend tokens |
| `ADMIN_EMAIL` | Default contact for automated notifications |
| `CREDENTIAL_CSV_KEY` | AES-256 key used to encrypt credential batches |
| `FRONTEND_BASE_URL` | Public URL for the participant application |

## 7. Next Steps

- Populate the `task_catalog` table with localized instructions.
- Implement the credential generation service (Python script) and store outputs in `admin/credentials/`.
- Build initial jsPsych experiments and connect them to the backend API.

For questions or contributions, please refer to the project README.
