-- 1. Create the dynamic Batches table (linked to a department)
CREATE TABLE batches (
    id BIGSERIAL PRIMARY KEY,
    department_id BIGINT NOT NULL REFERENCES departments(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    academic_year VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_dept_batch_name UNIQUE (department_id, name)
);

-- 2. Add roll_number and batch_id to the existing users table
ALTER TABLE users ADD COLUMN roll_number VARCHAR(50) UNIQUE;
ALTER TABLE users ADD COLUMN batch_id BIGINT REFERENCES batches(id) ON DELETE SET NULL;
