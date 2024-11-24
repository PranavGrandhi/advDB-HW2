-- Connect to the 'advdb' database
-- In PostgreSQL, you would specify the database when connecting:
-- psql -U username -d advdb

-- Drop existing tables if you are rerunning the experiment
DROP TABLE IF EXISTS uniform_data CASCADE;
DROP TABLE IF EXISTS skewed_data CASCADE;

-- Create the tables
CREATE TABLE uniform_data (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL
);

CREATE TABLE skewed_data (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL
);

-- Load the data into the tables
COPY uniform_data (id, user_id)
FROM '/home/sc10670/ADB/advDB-HW2/Q2/uniform_data_thumb2.csv'
DELIMITER ',' 
CSV HEADER;

COPY skewed_data (id, user_id)
FROM '/home/sc10670/ADB/advDB-HW2/Q2/skewed_data_thumb2.csv'
DELIMITER ',' 
CSV HEADER;

-- Update table statistics
ANALYZE uniform_data;
ANALYZE skewed_data;

-- **Non-Indexed Queries**

-- Query on uniform_data
EXPLAIN ANALYZE
SELECT user_id, COUNT(*) AS frequency
FROM uniform_data
WHERE user_id BETWEEN 100000 AND 200000
GROUP BY user_id
ORDER BY frequency DESC;

-- Query on skewed_data
EXPLAIN ANALYZE
SELECT user_id, COUNT(*) AS frequency
FROM skewed_data
WHERE user_id BETWEEN 1 AND 1000
GROUP BY user_id
ORDER BY frequency DESC;

-- **Indexed Queries**

-- Create indexes on user_id
CREATE INDEX idx_user_id ON uniform_data(user_id);
CREATE INDEX idx_user_id2 ON skewed_data(user_id);

-- Optionally, cluster the tables on the indexes, but not applying that for now to have consistency with MYSQL Analysis. 
-- CLUSTER uniform_data USING idx_user_id;
-- CLUSTER skewed_data USING idx_user_id2;

-- Update table statistics again after clustering
ANALYZE uniform_data;
ANALYZE skewed_data;

-- Rerun the queries with indexes in place

-- Query on uniform_data
EXPLAIN ANALYZE
SELECT user_id, COUNT(*) AS frequency
FROM uniform_data
WHERE user_id BETWEEN 100000 AND 200000
GROUP BY user_id
ORDER BY frequency DESC;

-- Query on skewed_data
EXPLAIN ANALYZE
SELECT user_id, COUNT(*) AS frequency
FROM skewed_data
WHERE user_id BETWEEN 1 AND 1000
GROUP BY user_id
ORDER BY frequency DESC;
