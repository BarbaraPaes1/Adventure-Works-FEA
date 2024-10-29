with
    sales_reason as(
        select
            salesorderid
            , salesreasonid
            , modifieddate
        from{{ source('erp_adventureworks','SALESORDERHEADERSALESREASON')}}
    )

select *
from sales_reason