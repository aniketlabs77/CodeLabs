-- 1. Create the Colleges table
CREATE TABLE colleges (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create the Departments table (linked to a college)
CREATE TABLE departments (
    id BIGSERIAL PRIMARY KEY,
    college_id BIGINT NOT NULL REFERENCES colleges(id) ON DELETE CASCADE,
    name VARCHAR(150) NOT NULL,
    code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_college_dept_code UNIQUE (college_id, code)
);
