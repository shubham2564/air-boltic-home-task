select
    cast("ID" as integer) as customer_group_id,
    trim("Type") as customer_group_type,
    trim("Name") as customer_group_name,
    trim("Registry number") as registry_number
from {{ ref('customer_group') }}
