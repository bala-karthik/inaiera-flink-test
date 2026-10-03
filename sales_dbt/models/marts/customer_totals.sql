select customer, count(*) as order_count, sum(amount) as total_spent
from {{ ref('stg_orders') }}
group by customer
