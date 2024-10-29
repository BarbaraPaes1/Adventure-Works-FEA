with
    state_province as (
        select
            stateprovinceid 
            , territoryid 
            , stateprovincecode 
            , countryregioncode 
            , name as state_name
            , modifieddate
        from{{ source('erp_adventureworks','STATEPROVINCE')}}
    )

select *
from state_province