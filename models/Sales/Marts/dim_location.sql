{{ config(materialized= 'table') }}

with
    sales_territory as (
        select
            territoryid,
            territory_name,
            'group' as continent_name,
            countryregioncode,
            salesytd,
            saleslastyear,
        from {{ ref('stg_erp__salesterritory') }}
    ),

    country_region as (
        select
            countryregioncode,
            country_name,
            modifieddate as country_modifieddate
        from {{ ref('stg_erp__countryregion') }}
    ),

    address as (
        select
            addressid,
            addressline,
            stateprovinceid,
            city,
            postalcode,
        from {{ ref('stg_erp__address') }}
    ),

    state_province as (
        select
            stateprovinceid,
            territoryid,
            stateprovincecode,
            countryregioncode,
            state_name,
        from {{ ref('stg_erp__stateprovince') }}
    ),

    joined_region as (
        select
            sales_territory.territoryid,
            sales_territory.territory_name,
            sales_territory.continent_name,
            sales_territory.salesytd,
            sales_territory.saleslastyear,
            address.addressid,
            address.addressline,
            address.city,
            address.postalcode,
            state_province.stateprovincecode,
            state_province.state_name,
            country_region.country_name,
        from sales_territory
        left join state_province 
            on sales_territory.territoryid = state_province.territoryid
        left join address 
            on state_province.stateprovinceid = address.stateprovinceid
        left join country_region 
            on sales_territory.countryregioncode = country_region.countryregioncode
    ),

    dim_Location as (
        select 
            {{ dbt_utils.generate_surrogate_key(['addressid']) }} as sk_region,
            *
        from joined_region
    )

select *
from dim_Location