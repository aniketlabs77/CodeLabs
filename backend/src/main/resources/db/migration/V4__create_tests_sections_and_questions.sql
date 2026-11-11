-- 1. TESTS: The overall assessment container
CREATE TABLE tests (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    duration_minutes INT NOT NULL,
    window_start TIMESTAMP WITH TIME ZONE NOT NULL,
    window_end TIMESTAMP WITH TIME ZONE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'DRAFT',
    max_tab_switches INT NOT NULL DEFAULT 3,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. TEST_BATCH_ASSIGNMENTS: Assigns a test to any number of dynamic batches
CREATE TABLE test_batch_assignments (
    id BIGSERIAL PRIMARY KEY,
    test_id BIGINT NOT NULL REFERENCES tests(id) ON DELETE CASCADE,
    batch_id BIGINT NOT NULL REFERENCES batches(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_test_batch UNIQUE (test_id, batch_id)
);

-- 3. TEST_SECTIONS: Divides a test into parts (Aptitude, Core CS, Coding)
CREATE TABLE test_sections (
    id BIGSERIAL PRIMARY KEY,
    test_id BIGINT NOT NULL REFERENCES tests(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    order_index INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. QUESTIONS: Individual questions inside a section
CREATE TABLE questions (
    id BIGSERIAL PRIMARY KEY,
    section_id BIGINT NOT NULL REFERENCES test_sections(id) ON DELETE CASCADE,
    prompt TEXT NOT NULL,
    question_type VARCHAR(50) NOT NULL DEFAULT 'MCQ',
    marks NUMERIC(5, 2) NOT NULL DEFAULT 1.00,
    negative_marks NUMERIC(5, 2) NOT NULL DEFAULT 0.00,
    explanation TEXT,
    order_index INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. QUESTION_OPTIONS: Multiple-choice choices for MCQ questions
CREATE TABLE question_options (
    id BIGSERIAL PRIMARY KEY,
    question_id BIGINT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    option_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    order_index INT NOT NULL DEFAULT 1
);

-- Production Indexes for fast lookup during high concurrency
CREATE INDEX idx_test_sections_test_id ON test_sections(test_id);
CREATE INDEX idx_questions_section_id ON questions(section_id);
CREATE INDEX idx_question_options_question_id ON question_options(question_id);
CREATE INDEX idx_test_batch_test_id ON test_batch_assignments(test_id);
CREATE INDEX idx_test_batch_batch_id ON test_batch_assignments(batch_id);
