# Frontend Scaffold

The frontend will deliver the participant-facing application, including consent, questionnaires, the cognitive test battery, and normative feedback visualizations.

## Planned Stack

- **Framework**: React 18 with TypeScript
- **State Management**: Redux Toolkit or Zustand for cross-test state
- **UI Library**: Tailwind CSS + Headless UI for accessibility-compliant components
- **Experiment Engine**: jsPsych 7 with custom plugins for memory and reaction time tasks
- **Internationalization**: react-i18next for Portuguese (Brazil) localization

## Target Directory Layout

```
frontend/
├── src/
│   ├── components/
│   ├── features/
│   ├── hooks/
│   ├── pages/
│   ├── providers/
│   ├── routes/
│   ├── services/
│   └── main.tsx
├── public/
├── package.json
└── README.md
```

## UX Flow Highlights

1. **Login Screen** – Validate participant credentials, collect device metadata.
2. **Consent + Questionnaire** – Capture required demographics before unlocking tests.
3. **Task Launcher** – Presents 13 tasks in fixed order; each task includes training, instructions, and optional audio playback.
4. **Inter-test Pause** – Allow breaks and track durations for metadata.
5. **Feedback Portal** – Separate login reveals normative comparisons, bar charts, and textual interpretation.

## Implementation Notes

- Persist progress locally (IndexedDB) to recover from accidental refreshes.
- Wrap jsPsych tasks to stream partial results to the backend API.
- Enforce training completion logic; automatically skip after two failed attempts.
- Display desktop usage recommendation when viewport width < 1024px.

The initial React scaffolding will be added in the next development cycle.
