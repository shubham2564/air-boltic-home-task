select
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone_number,

    c.customer_group_id,
    g.customer_group_type,
    g.customer_group_name,
    g.registry_number

from {{ ref('stg_customer') }} c
left join {{ ref('stg_customer_group') }} g
  on c.customer_group_id = g.customer_group_id
