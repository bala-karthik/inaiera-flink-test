-- 1. SOURCE: fake orders, 2 per second
CREATE TABLE live_orders (
    order_id INT,
    amount DOUBLE,
    order_time AS PROCTIME()
) WITH (
    'connector' = 'datagen',
    'rows-per-second' = '2'
);

-- 2. SINK: throws the results away
CREATE TABLE order_totals (
    window_start TIMESTAMP(3),
    window_end TIMESTAMP(3),
    total_amount DOUBLE
) WITH (
    'connector' = 'blackhole'
);

-- 3. ACTION: total amount every 10 seconds
INSERT INTO order_totals
SELECT window_start, window_end, SUM(amount)
FROM TABLE(TUMBLE(TABLE live_orders, DESCRIPTOR(order_time), INTERVAL '10' SECOND))
GROUP BY window_start, window_end;
