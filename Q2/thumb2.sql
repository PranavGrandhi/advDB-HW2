USE advdb;

CREATE TABLE uniform_data (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL
);

CREATE TABLE skewed_data (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\uniform_data_thumb2.csv'
INTO TABLE uniform_data
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, user_id);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\skewed_data_thumb2.csv'
INTO TABLE skewed_data
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, user_id);

-- Non Indexed Queries
SELECT user_id, COUNT(*) AS frequency
FROM uniform_data
WHERE user_id BETWEEN 100000 AND 200000
GROUP BY user_id
ORDER BY frequency DESC;

SELECT user_id, COUNT(*) AS frequency
FROM skewed_data
WHERE user_id BETWEEN 1 AND 1000
GROUP BY user_id
ORDER BY frequency DESC;

-- Indexed Queries
CREATE INDEX idx_user_id ON uniform_data(user_id);
CREATE INDEX idx_user_id2 ON skewed_data(user_id);

SELECT user_id, COUNT(*) AS frequency
FROM uniform_data
WHERE user_id BETWEEN 100000 AND 200000
GROUP BY user_id
ORDER BY frequency DESC;

SELECT user_id, COUNT(*) AS frequency
FROM skewed_data
WHERE user_id BETWEEN 1 AND 1000
GROUP BY user_id
ORDER BY frequency DESC;