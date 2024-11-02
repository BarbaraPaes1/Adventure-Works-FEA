{{ config(materialized= 'table') }}

with
    sales_reason as (
        select
            salesorderid,
            salesreasonid,
        from {{ ref('stg_erp__reason') }}
    ),

    reason as (
        select
            salesreasonid,
            salereason_name,
            reason_type,
        from {{ ref('stg_erp__salesreason') }}
    ),

    joined_reason as (
        select
            sales_reason.salesorderid,
            LISTAGG(reason.salereason_name, ', ') as reason_agg 
        from sales_reason
        left join reason 
            on sales_reason.salesreasonid = reason.salesreasonid
        group by 
            sales_reason.salesorderid
    ),

    final_reason as (
        select 
            {{ dbt_utils.generate_surrogate_key(['salesorderid']) }} as sk_reason,
            salesorderid,
            reason_agg,
            reason_type
        from joined_reason
    )

select *
from final_reason