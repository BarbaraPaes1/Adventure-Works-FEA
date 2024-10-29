{{ config(materialized= 'table') }}

with sale_detail as (
    select
        salesorderid,
        productid,
        orderqty,
        unitprice,
        unitpricediscount,
        COALESCE(unitprice * (1.0 - COALESCE(unitpricediscount, 0.0)) * orderqty, 0.0) as linetotal,
        modifieddate as sale_modifieddate
    from {{ source('erp_adventureworks', 'SALESORDERDETAIL') }}
)

select 
    sd.salesorderid,
    sd.productid,
    sd.orderqty,
    sd.unitprice,
    sd.unitpricediscount,
    sd.linetotal,
    sd.sale_modifieddate,
    fr.sk_reason,
    fr.reason_agg
from sale_detail sd
left join {{ ref('int_salesdetail_reason') }} fr
    on sd.salesorderid = fr.salesorderid