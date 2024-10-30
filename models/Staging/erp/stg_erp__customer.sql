with
    customer as(
        select
            customerid
            , personid
            , territoryid
            , modifieddate
        from {{ source('erp_adventureworks','CUSTOMER')}}
    )

select *
from customer