SET GLOBAL wait_timeout = 3000;
SET GLOBAL interactive_timeout = 3000;
SET GLOBAL net_read_timeout = 3000;
SET GLOBAL net_write_timeout = 3000;

USE advdb;

CREATE TABLE trades_uniform (
    stock_symbol VARCHAR(10),
    time BIGINT,
    quantity INT,
    price DECIMAL(10, 2)
);

CREATE TABLE trades_fractal (
    stock_symbol VARCHAR(10),
    time BIGINT,
    quantity INT,
    price DECIMAL(10, 2)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\uniform_trades.csv'
INTO TABLE trades_uniform
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(stock_symbol, time, quantity, price);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\fractal_trades.csv'
INTO TABLE trades_fractal
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(stock_symbol, time, quantity, price);

-- Cluster
ALTER TABLE trades_uniform ADD PRIMARY KEY (stock_symbol, time);
ALTER TABLE trades_fractal ADD PRIMARY KEY (stock_symbol, time);

-- 7.047 seconds (Uniform Clustered)
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_uniform
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;

-- 7.156 seconds (Fractal Clustered)
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_fractal
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;

-- Remove Clustering and add index
ALTER TABLE trades_uniform DROP PRIMARY KEY;
ALTER TABLE trades_fractal DROP PRIMARY KEY;
CREATE INDEX idx_uniform_nonclustered ON trades_uniform (stock_symbol, time);
CREATE INDEX idx_fractal_nonclustered ON trades_fractal (stock_symbol, time);

-- 8.641 seconds (Uniform Non-Clustered)
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_uniform
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;

-- 8.656 seconds (Fractal Non-Clustered)
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_fractal
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;