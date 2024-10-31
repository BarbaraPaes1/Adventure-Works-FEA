with
    sales_reason as (
        select
            salesreasonid,  
            name as salereason_name,
            reasontype as reason_type
        from {{ source('erp_adventureworks', 'SALESREASON') }}
    )

select *
from sales_reason