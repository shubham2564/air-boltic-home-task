select
    cast("Customer ID" as integer) as customer_id,
    trim("Name") as customer_name,
    cast("Customer Group ID" as integer) as customer_group_id,
    lower(trim("Email")) as email,
    trim("Phone Number") as phone_number
from {{ ref('customer') }}
