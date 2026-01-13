select
    cast("Order ID" as integer) as order_id,
    cast("Customer ID" as integer) as customer_id,
    cast("Trip ID" as integer) as trip_id,
    cast("Price (EUR)" as double) as price_eur,
    trim("Seat No") as seat_no,
    lower(trim("Status")) as status
from {{ ref('order') }}
