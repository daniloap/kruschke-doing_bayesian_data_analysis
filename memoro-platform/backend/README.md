# Backend Scaffold

The backend will expose a secure REST API supporting participant flows, metadata collection, normative feedback, and administrative operations.

## Proposed Stack

- **Framework**: FastAPI (Python) or Express (Node.js)
- **Database Layer**: SQLAlchemy + Alembic (if Python) or Prisma/TypeORM (if Node.js)
- **Auth**: Credential pair validation with rate limiting and audit logging
- **Task Logging**: Endpoints for training completion, task start/end, and result submissions
- **Feedback**: Aggregation endpoints that compute normative comparisons on demand

## Suggested Directory Layout

```
backend/
├── app/
│   ├── api/
│   ├── core/
│   ├── models/
│   ├── schemas/
│   ├── services/
│   └── main.py
├── tests/
├── pyproject.toml (if Python) or package.json (if Node.js)
└── README.md
```

## Immediate Next Actions

1. Finalize the technology choice (FastAPI vs Express) based on team expertise.
2. Implement authentication endpoints:
   - `POST /auth/login` for credential validation.
   - `POST /sessions` to initialize a participant run after consent.
3. Model the questionnaire submission endpoint (`POST /participants/{id}/profile`).
4. Define `POST /tasks/{task_key}/results` to accept jsPsych data payloads.
5. Create admin-protected endpoints for CSV exports and credential provisioning.

Configuration files and dependency manifests will be added in the next iteration.
