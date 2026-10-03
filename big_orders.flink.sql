CREATE TABLE raw_orders (
    order_id INT,
    amount INT
) WITH (
    'connector' = 'datagen',
    'rows-per-second' = '3',
    'fields.amount.min' = '1',
    'fields.amount.max' = '100'
);

CREATE TABLE big_orders (
    order_id INT,
    amount INT
) WITH (
    'connector' = 'blackhole'
);

INSERT INTO big_orders
SELECT order_id, amount FROM raw_orders WHERE amount > 50;
