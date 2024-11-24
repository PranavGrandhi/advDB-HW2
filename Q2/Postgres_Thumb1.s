SET statement_timeout = '3000s';
SET idle_in_transaction_session_timeout = '3000s';


CREATE TABLE trades_uniform (
    stock_symbol VARCHAR(10),
    time BIGINT,
    quantity INT,
    price NUMERIC(10, 2)
);

CREATE TABLE trades_fractal (
    stock_symbol VARCHAR(10),
    time BIGINT,
    quantity INT,
    price NUMERIC(10, 2)
);

COPY trades_uniform (stock_symbol, time, quantity, price)
FROM '/tmp/uniform_trades.csv'
DELIMITER ',' 
CSV HEADER;

COPY trades_fractal (stock_symbol, time, quantity, price)
FROM '/tmp/fractal_trades.csv'
DELIMITER ',' 
CSV HEADER;


ALTER TABLE trades_uniform ADD PRIMARY KEY (stock_symbol, time);
ALTER TABLE trades_fractal ADD PRIMARY KEY (stock_symbol, time);
CLUSTER trades_uniform USING trades_uniform_pkey;
CLUSTER trades_fractal USING trades_fractal_pkey;

EXPLAIN ANALYZE
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_uniform
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;


EXPLAIN ANALYZE
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_fractal
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;


ALTER TABLE trades_uniform DROP CONSTRAINT trades_uniform_pkey;
ALTER TABLE trades_fractal DROP CONSTRAINT trades_fractal_pkey;

CREATE INDEX idx_uniform_nonclustered ON trades_uniform (stock_symbol, time);
CREATE INDEX idx_fractal_nonclustered ON trades_fractal (stock_symbol, time);


EXPLAIN ANALYZE
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_uniform
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;

EXPLAIN ANALYZE
SELECT stock_symbol, time, quantity, price, 
       SUM(quantity) AS total_quantity, 
       AVG(price) AS avg_price
FROM trades_fractal
WHERE time BETWEEN 100000 AND 800000 
  AND price > 100
  AND quantity BETWEEN 500 AND 8000
GROUP BY stock_symbol, time, quantity, price
ORDER BY total_quantity DESC, avg_price ASC;
