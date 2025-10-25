# Admin Dashboard Scaffold

The admin module will provide researcher-only tooling for monitoring participation, generating access codes, and exporting study data.

## Planned Features

- **Authentication**: Strong password or SSO integration for research staff.
- **Dashboard Metrics**:
  - Total invitations issued vs. completed sessions
  - Drop-off rate per cognitive task
  - Device distribution (desktop vs mobile)
  - Average completion time
- **Credential Management**:
  - Generate 10,000 unique access codes with 8-digit IDs and 6-digit passcodes
  - AES-256 encryption for CSV export files
  - Audit log of downloads and key usage
- **Data Export**:
  - CSV/JSON exports combining participants, sessions, task results, and feedback summaries
  - Scheduled exports delivered securely to SFTP or cloud storage
- **System Health**: API status checks, error monitoring, and log viewer hooks

## Directory Placeholder

```
admin/
├── README.md
└── (future) credentials/
    └── .gitignore (to keep generated CSVs out of version control)
```

Additions such as React components, serverless functions, or CLI scripts will be introduced as implementation progresses.
