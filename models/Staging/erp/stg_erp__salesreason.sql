with
    sales_reason as (
        select
            salesorderid as salesorderid,  
            name as salereason_name,
            reasontype as reason_type
        from {{ source('erp_adventureworks', 'SALESREASON') }}
    )

select *
from sales_reason