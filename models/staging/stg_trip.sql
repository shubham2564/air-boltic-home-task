select
    cast("Trip ID" as integer) as trip_id,
    trim("Origin City") as origin_city,
    trim("Destination City") as destination_city,
    cast("Airplane ID" as integer) as aeroplane_id,
    cast("Start Timestamp" as timestamp) as start_ts,
    cast("End Timestamp" as timestamp) as end_ts
from {{ ref('trip') }}
