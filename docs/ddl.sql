-- Air Boltic analytics model (DDL)
-- Star-schema style: dimensions + facts for self-serve analysis and KPI monitoring.

-- =========================
-- Dimensions
-- =========================

create table if not exists dim_date (
  date_day      date primary key,
  year          integer,
  quarter       integer,
  month         integer,
  week_of_year  integer,
  day_of_month  integer,
  is_weekend    boolean
);

create table if not exists dim_city (
  city_key    varchar primary key,
  city_name   varchar not null,
  country     varchar,
  region      varchar
);

create table if not exists dim_route (
  route_id              varchar primary key,
  origin_city_key       varchar not null references dim_city(city_key),
  destination_city_key  varchar not null references dim_city(city_key)
);

create table if not exists dim_customer_group (
  customer_group_id     integer primary key,
  customer_group_type   varchar not null,
  customer_group_name   varchar,
  registry_number       varchar
);

create table if not exists dim_customer (
  customer_id           integer primary key,
  customer_name         varchar,
  email                 varchar,
  phone_number          varchar,
  customer_group_id     integer references dim_customer_group(customer_group_id),
  customer_group_type   varchar,
  customer_group_name   varchar
);

create table if not exists dim_aeroplane_model (
  manufacturer      varchar not null,
  aeroplane_model   varchar not null,
  max_seats         integer,
  max_weight        integer,
  max_distance      integer,
  engine_type       varchar,
  primary key (manufacturer, aeroplane_model)
);

create table if not exists dim_aeroplane (
  aeroplane_id      integer primary key,
  manufacturer      varchar not null,
  aeroplane_model   varchar not null,
  max_seats         integer,
  max_weight        integer,
  max_distance      integer,
  engine_type       varchar
);

-- =========================
-- Facts
-- =========================

create table if not exists fct_trips (
  trip_id                integer primary key,
  aeroplane_id            integer not null references dim_aeroplane(aeroplane_id),
  origin_city_key         varchar not null references dim_city(city_key),
  destination_city_key    varchar not null references dim_city(city_key),
  route_id                varchar references dim_route(route_id),
  start_ts                timestamp not null,
  end_ts                  timestamp,
  trip_day                date not null references dim_date(date_day),
  trip_duration_minutes   integer,
  trip_status             varchar
);

create table if not exists fct_orders (
  order_id               integer primary key,
  customer_id            integer not null references dim_customer(customer_id),
  trip_id                integer not null references fct_trips(trip_id),
  price_eur              double not null,
  seat_no                varchar,
  status                 varchar not null,
  trip_day               date references dim_date(date_day),
  origin_city_key         varchar references dim_city(city_key),
  destination_city_key    varchar references dim_city(city_key),
  aeroplane_id           integer references dim_aeroplane(aeroplane_id)
);

-- Optional pre-aggregations for dashboard performance and consistent KPIs.
create table if not exists fct_daily_service_kpis (
  metric_day        date not null references dim_date(date_day),
  origin_region     varchar,
  destination_region varchar,
  orders_count      integer,
  trips_count       integer,
  active_customers  integer,
  revenue_eur       double,
  primary key (metric_day, origin_region, destination_region)
);

create table if not exists fct_customer_activity_daily (
  activity_day      date not null references dim_date(date_day),
  customer_id       integer not null references dim_customer(customer_id),
  orders_count      integer,
  revenue_eur       double,
  primary key (activity_day, customer_id)
);

