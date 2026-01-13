select
    o.order_id,
    o.customer_id,
    o.trip_id,
    o.price_eur,
    o.seat_no,
    o.status,

    t.origin_city,
    t.destination_city,
    t.start_ts,
    t.end_ts,
    date_trunc('day', t.start_ts) as trip_day,

    t.aeroplane_id

from {{ ref('stg_order') }} o
left join {{ ref('stg_trip') }} t
  on o.trip_id = t.trip_id

