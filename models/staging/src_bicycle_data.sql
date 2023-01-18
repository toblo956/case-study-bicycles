{{
    config(
        materialized='table',
        description='Data of bicycle rides for a company to analyze further.',
        persist_docs={"relation": true, "columns": false},
        schema='staging'
    )
}}

with source as (
    select * from {{ source('cycle_data', "2022*")}}
),

source_cleaned as (
    select
        cast(ride_id as string) as ride_id,
        rideable_type as bike_type,
        started_at as started_at,
        ended_at as ended_at,
        cast(start_station_name as string) as start_station_name,
        start_station_id,
        cast(end_station_name as string) as end_station_name,
        end_station_id,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        case
            when start_lng is not null and start_lat is not null then ST_GEOGPOINT(start_lng, start_lat)
            else null
        end as start_geog,
        /* end_geog */
        case
            when end_lng is not null and end_lat is not null then ST_GEOGPOINT(end_lng, end_lat)
            else null
        end as end_geog,
        member_casual as member_type,

    from source
),
final as ( 
    select
        ride_id,
        bike_type,
        started_at,
        ended_at,
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,
        member_type,
        /* ride_duration */
        timestamp_diff(ended_at, started_at, SECOND) as ride_duration,

        /* start weekday bigquery */
        case
            when extract(DAYOFWEEK from started_at) = 1 then 'Sunday'
            when extract(DAYOFWEEK from started_at) = 2 then 'Monday'
            when extract(DAYOFWEEK from started_at) = 3 then 'Tuesday'
            when extract(DAYOFWEEK from started_at) = 4 then 'Wednesday'
            when extract(DAYOFWEEK from started_at) = 5 then 'Thursday'
            when extract(DAYOFWEEK from started_at) = 6 then 'Friday'
            when extract(DAYOFWEEK from started_at) = 7 then 'Saturday'
        end as started_at_weekday,

        /* end weekday bigquery */
        case
            when extract(DAYOFWEEK from ended_at) = 1 then 'Sunday'
            when extract(DAYOFWEEK from ended_at) = 2 then 'Monday'
            when extract(DAYOFWEEK from ended_at) = 3 then 'Tuesday'
            when extract(DAYOFWEEK from ended_at) = 4 then 'Wednesday'
            when extract(DAYOFWEEK from ended_at) = 5 then 'Thursday'
            when extract(DAYOFWEEK from ended_at) = 6 then 'Friday'
            when extract(DAYOFWEEK from ended_at) = 7 then 'Saturday'
        end as ended_at_weekday,

        /* distance travelled bigquery */
        start_geog,
        end_geog,
        case
            when start_geog is not null and end_geog is not null then ST_DISTANCE(start_geog, end_geog)
            else null
        end as distance_travelled,
        date(timestamp_trunc(started_at, month)) as started_at_month,
	
    from source_cleaned

)

select * from final