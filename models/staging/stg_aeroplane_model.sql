select
    trim(manufacturer) as manufacturer,
    trim(model) as aeroplane_model,
    cast(max_seats as integer) as max_seats,
    cast(max_weight as integer) as max_weight,
    cast(max_distance as integer) as max_distance,
    trim(engine_type) as engine_type
from {{ ref('aeroplane_model') }}
