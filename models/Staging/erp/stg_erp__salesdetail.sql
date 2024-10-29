with
    sale_detail as (
        select
            salesorderid
            , productid
            , orderqty
            , unitprice
            , unitpricediscount
            , COALESCE(unitprice * (1.0 - COALESCE(unitpricediscount, 0.0)) * orderqty, 0.0) as linetotal
            , modifieddate
        from {{ source('erp_adventureworks','SALESORDERDETAIL')}}
    )

select *
from sale_detail