{{ config(materialized= 'table') }}

with
    customer as (
            select
            customerid
            , personid
            , territoryid
            , modifieddate
        from {{ref('stg_erp__customer')}}
    )

    , person as (
        select
            businessentityid
            , persontype
            , firstname
            , middlename
            , lastname
            , fullname
            , modifieddate
        from {{ref('stg_erp__person')}}
    )

    , joined_customer as (
        select 
            customer.customerid
            , person.businessentityid
            , customer.storeid
            , person.firstname
            , person.middlename
            , person.lastname
            , person.fullname
        from customer
        left join person on customer.customerid = person.businessentityid
        where person.persontype = 'IN'
    )

    , dim_customer as (
        select 
            {{ dbt_utils.generate_surrogate_key(['customerid', 'businessentityid', 'fullname']) }} as sk_customer
            , *
        from joined_customer
    )

select *
from dim_customer