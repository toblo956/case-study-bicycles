{{config(required_tests=None)}}
with source as (
    select * from {{ ref('src_bicycle_data') }}
)

select * from source