with
    country_region as (
        select
            countryregioncode
            , name as country_name
            , modifieddate
        from{{ source('erp_adventureworks','COUNTRYREGION')}}
    )

select *
from country_region

















