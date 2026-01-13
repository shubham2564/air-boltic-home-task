select
    a.aeroplane_id,
    a.manufacturer,
    a.aeroplane_model,

    m.max_seats,
    m.max_weight,
    m.max_distance,
    m.engine_type

from {{ ref('stg_aeroplane') }} a
left join {{ ref('stg_aeroplane_model') }} m
  on a.manufacturer = m.manufacturer
 and a.aeroplane_model = m.aeroplane_model
