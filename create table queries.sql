-- Clean out the old layout structure
DROP TABLE IF EXISTS dim_job_skills;
DROP TABLE IF EXISTS fact_jobs;
DROP TABLE IF EXISTS dim_locations;

-- 1. Create the new location dimension table
CREATE TABLE dim_locations (
    location_id INT PRIMARY KEY,
    location_raw VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    continent VARCHAR(100)
);

-- 2. Create the fact table containing our normalized USD fields
CREATE TABLE fact_jobs (
    job_id BIGINT PRIMARY KEY,
    company VARCHAR(255),
    standardized_role VARCHAR(100),
    location_id INT,
    salary_min_usd NUMERIC(12,2),
    salary_max_usd NUMERIC(12,2),
    salary_status VARCHAR(100),
    currency_original VARCHAR(20),
    CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES dim_locations(location_id)
);

-- 3. Create the skills bridge dimension table
CREATE TABLE dim_job_skills (
    skill_id SERIAL PRIMARY KEY,
    job_id BIGINT,
    skill_name VARCHAR(100),
    skill_category VARCHAR(100),
    CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES fact_jobs(job_id)
);