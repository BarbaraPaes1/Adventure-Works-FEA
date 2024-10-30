with
    address as (
        select
            addressid
            , stateprovinceid
            , addressline1 as addressline
            , city 
            , postalcode
            , modifieddate
        from {{ source('erp_adventureworks','ADDRESS')}}
    )

select *
from address