# Memoro-Inspired Cognitive Testing Platform

This repository contains the initial project structure for a self-administered cognitive testing platform inspired by Memoro and the HUNT4-Hjernetrim study. The system is organized to support a modern web application with strict research, security, and compliance requirements.

## Project Layout

```
memoro-platform/
├── README.md
├── frontend/
├── backend/
├── database/
├── admin/
└── docs/
```

Each folder is intended to host the following components:

- **frontend/** – React + TypeScript application with jsPsych integration, participant flow, and feedback visualizations.
- **backend/** – REST API (FastAPI or Express) responsible for authentication, task orchestration, metadata capture, and normative feedback computation.
- **database/** – SQL schemas, migrations, and seed data for participants, sessions, tasks, and normative tables.
- **admin/** – Administrative dashboard for monitoring participation, generating credential batches, and exporting datasets.
- **docs/** – Researcher and deployment documentation, including consent procedures, installation instructions, and invitation templates.

## Next Steps

1. Initialize the frontend with a React + TypeScript scaffolding (e.g., Vite) and integrate jsPsych plugins for the cognitive tasks.
2. Scaffold the backend API with secure credential validation, task logging endpoints, and normative score calculations.
3. Implement the admin dashboard with data exports, statistics, and credential generation tools.
4. Populate the docs/ directory with operational guides, ethics documentation, and deployment instructions.

Refer to `database/schema.sql` for the relational model that supports participant sessions and task results.
