with
    territory as (
        select
            territoryid,
            name as territory_name,
            "group" as continent_name, 
            countryregioncode,
            salesytd,
            saleslastyear,
            modifieddate
        from {{ source('erp_adventureworks', 'SALESTERRITORY') }} t
    )

select *
from territory