# Researcher Overview

This document summarizes the research-oriented requirements for the Memoro-style platform and highlights where each requirement will be implemented within the codebase.

## Participant Journey

1. **Credential Login** – Unique 8-digit code + 6-digit passcode validated server-side.
2. **Digital Consent** – Timestamp stored in the `sessions` table (`consent_given_at`).
3. **Baseline Questionnaire** – Demographic data persisted with the participant record.
4. **Cognitive Battery** – Fixed order defined in `database/schema.sql` via `task_catalog`.
5. **Feedback & Debrief** – Norm-based summary provided after completion.
6. **Post-session Survey** – Interruptions and qualitative feedback saved as part of session metadata.

## Data Model Highlights

- **Participants**: Stores credential pairs, demographics, and enrollment metadata.
- **Sessions**: Represents each battery completion attempt, including device fingerprints and consent status.
- **Task Results**: Trial-level outcomes, training compliance, and metrics such as reaction times and accuracy.
- **Norms**: Aggregated benchmarks stratified by age bracket, sex, and education level for normative feedback.
- **Task Catalog**: Reference table ensuring consistent task ordering and metadata across services.

## Compliance Considerations

- Personally identifying information is excluded by design; participant codes are pseudonymous identifiers.
- IP addresses are salted and hashed prior to storage (`sessions.ip_hash`).
- Audit trails leverage timestamp columns with automatic update triggers to track modifications.
- Consent acceptance is mandatory prior to starting the first task and recorded with a precise timestamp.

## Metadata Collection

Backend endpoints will capture the following metadata and map them to the `sessions` and `task_results` tables:

- Device type, operating system, browser name/version, screen resolution.
- User agent string for research reproducibility.
- Training attempts and outcomes for quality control.
- Reaction time arrays stored as JSON for downstream analyses.

## Next Deliverables

- Credential batch generator (Python script) exporting AES-256 encrypted CSV files stored in `admin/credentials/`.
- Backend API specification covering authentication, questionnaire submission, task logging, and feedback retrieval.
- Frontend wireframes for each participant flow stage, to be stored in `docs/wireframes/`.
- Administrator dashboard requirements documentation with KPIs and audit logs.

Researchers can extend this document with protocol-specific notes, ethics approvals, and version history as the project matures.
