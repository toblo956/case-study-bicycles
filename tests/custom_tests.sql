 select
    ride_id
 from {{ ref('bicycle_data_agg') }}
 group by ride_id
 having count(*) > 1