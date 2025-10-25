-- Schema for the Memoro-inspired cognitive testing platform.
-- Target database: PostgreSQL 14+

CREATE TABLE participants (
    id SERIAL PRIMARY KEY,
    participant_code CHAR(12) NOT NULL UNIQUE,
    passcode CHAR(6) NOT NULL,
    birth_year SMALLINT,
    sex VARCHAR(16),
    education_level VARCHAR(32),
    hand_dominance VARCHAR(16),
    computer_familiarity SMALLINT CHECK (computer_familiarity BETWEEN 1 AND 5),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE sessions (
    id BIGSERIAL PRIMARY KEY,
    participant_id INTEGER NOT NULL REFERENCES participants(id) ON DELETE CASCADE,
    session_uuid UUID NOT NULL DEFAULT gen_random_uuid(),
    consent_given_at TIMESTAMPTZ NOT NULL,
    started_at TIMESTAMPTZ NOT NULL,
    completed_at TIMESTAMPTZ,
    session_status VARCHAR(24) NOT NULL CHECK (session_status IN ('in_progress', 'completed', 'aborted')),
    device_type VARCHAR(16),
    operating_system VARCHAR(32),
    browser VARCHAR(32),
    screen_resolution VARCHAR(24),
    user_agent TEXT,
    ip_hash CHAR(64),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_sessions_participant_id ON sessions(participant_id);
CREATE INDEX idx_sessions_session_status ON sessions(session_status);

CREATE TABLE task_results (
    id BIGSERIAL PRIMARY KEY,
    session_id BIGINT NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
    task_order SMALLINT NOT NULL CHECK (task_order BETWEEN 1 AND 13),
    task_key VARCHAR(64) NOT NULL,
    started_at TIMESTAMPTZ NOT NULL,
    completed_at TIMESTAMPTZ,
    task_status VARCHAR(24) NOT NULL CHECK (task_status IN ('completed', 'failed', 'aborted', 'skipped_training')),
    training_attempts SMALLINT NOT NULL DEFAULT 0,
    training_status VARCHAR(24) NOT NULL CHECK (training_status IN ('passed', 'failed', 'skipped')),
    reaction_times_ms JSONB,
    score NUMERIC(8,3),
    accuracy NUMERIC(5,2),
    error_count SMALLINT,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_task_results_session_id ON task_results(session_id);
CREATE INDEX idx_task_results_task_key ON task_results(task_key);
CREATE INDEX idx_task_results_task_status ON task_results(task_status);

CREATE TABLE norms (
    id BIGSERIAL PRIMARY KEY,
    task_key VARCHAR(64) NOT NULL,
    age_min SMALLINT NOT NULL,
    age_max SMALLINT NOT NULL,
    sex VARCHAR(16) NOT NULL,
    education_level VARCHAR(32) NOT NULL,
    mean_score NUMERIC(8,3) NOT NULL,
    std_dev NUMERIC(8,3),
    percentile_5 NUMERIC(8,3),
    percentile_25 NUMERIC(8,3),
    percentile_50 NUMERIC(8,3),
    percentile_75 NUMERIC(8,3),
    percentile_95 NUMERIC(8,3),
    sample_size INTEGER,
    CONSTRAINT chk_norms_age CHECK (age_min <= age_max)
);

CREATE INDEX idx_norms_lookup ON norms(task_key, age_min, age_max, sex, education_level);

-- Trigger to keep participant timestamps in sync.
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_participants_updated
BEFORE UPDATE ON participants
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_sessions_updated
BEFORE UPDATE ON sessions
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- Enumerations for allowed task keys.
-- This optional lookup aids validation across services.
CREATE TABLE task_catalog (
    task_key VARCHAR(64) PRIMARY KEY,
    display_name VARCHAR(128) NOT NULL,
    domain VARCHAR(64) NOT NULL,
    default_duration_minutes NUMERIC(4,1) NOT NULL,
    order_index SMALLINT NOT NULL UNIQUE
);

INSERT INTO task_catalog (task_key, display_name, domain, default_duration_minutes, order_index) VALUES
    ('simple_reaction_time', 'Simple Reaction Time', 'Processing Speed', 1.0, 1),
    ('pattern_separation', 'Pattern Separation', 'Episodic Memory', 3.0, 2),
    ('visual_memory_immediate', 'Visual Memory (Immediate)', 'Visual Memory', 2.0, 3),
    ('verbal_memory_learning', 'Verbal Memory (Learning + Recall)', 'Verbal Memory', 4.0, 4),
    ('symbol_digit_coding_main', 'Symbol-Digit Coding (Main)', 'Processing Speed', 2.0, 5),
    ('symbol_digit_coding_recall', 'Symbol-Digit Coding (Recall Key)', 'Implicit Memory', 1.0, 6),
    ('digit_span_forward', 'Digit Span Forward', 'Working Memory', 3.0, 7),
    ('visual_memory_delayed', 'Visual Memory (Delayed)', 'Long-term Memory', 1.0, 8),
    ('visual_memory_recognition', 'Visual Memory (Recognition)', 'Recognition', 2.0, 9),
    ('digit_span_backwards', 'Digit Span Backwards', 'Working Memory & Control', 3.0, 10),
    ('verbal_memory_delayed', 'Verbal Memory (Delayed Recall)', 'Long-term Memory', 2.0, 11),
    ('verbal_memory_recognition', 'Verbal Memory (Recognition)', 'Recognition', 2.0, 12),
    ('complex_reaction_time', 'Complex Reaction Time', 'Attention & Inhibition', 3.0, 13);
