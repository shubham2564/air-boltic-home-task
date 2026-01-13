select
    cast("Airplane ID" as integer) as aeroplane_id,
    trim("Airplane Model") as aeroplane_model,
    trim("Manufacturer") as manufacturer
from {{ ref('aeroplane') }}
