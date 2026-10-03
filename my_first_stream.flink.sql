-- 1. THE SOURCE: A fake live stream of clicks (generates 1 click per second)
CREATE TABLE live_clicks (
    user_id INT,
    page_url STRING,
    click_time TIMESTAMP(3)
) WITH (
    'connector' = 'datagen',
    'rows-per-second' = '1'
);


-- 2. THE SINK: Where to send the data. "blackhole" just safely absorbs it.
CREATE TABLE click_sink (
    user_id INT,
    page_url STRING,
    click_time TIMESTAMP(3)
) WITH (
    'connector' = 'blackhole'
);

-- 3. THE ACTION: Continuously move data from the source to the sink
INSERT INTO click_sink 
SELECT user_id, page_url, click_time 
FROM live_clicks;


