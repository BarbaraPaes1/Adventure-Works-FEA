{{ config(materialized= 'table') }}

with

    dim_location as (
        select 
            *
        from {{ ref('dim_location') }}
    ),

    dim_customer as (
        select 
            *
        from {{ ref('dim_customer') }}
    ),

    dim_product as (
        select 
            *
        from {{ ref('dim_product') }}
    ),

    dim_creditcard as (
        select 
            *
        from {{ ref('dim_creditcard') }}
    ),

    dim_calender as (
        select 
            *
        from {{ ref('dim_calender') }}
    ),

    dim_salesdetails as (
        select 
            *
        from {{ ref('dim_salesdetails') }}
    ),

    fac_salesorder as (
        select
            salesheader.salesorderid,
            dim_location.sk_region as fk_region,
            dim_creditcard.sk_creditcard as fk_creditcard,
            dim_customer.sk_customer as fk_customer,
            dim_calender.sk_calendar as fk_calendar,
            salesheader.orderdate,
            salesheader.duedate,
            salesheader.shipdate,
            case
                when salesheader.status = 1 then 'In process'
                when salesheader.status = 2 then 'Approved'
                when salesheader.status = 3 then 'Backordered'
                when salesheader.status = 4 then 'Rejected'
                when salesheader.status = 5 then 'Shipped'
                when salesheader.status = 6 then 'Cancelled'
            end as order_status,
            salesheader.subtotal,
            salesheader.taxamt,
            salesheader.freight,
            salesheader.totaldue
        from {{ ref('stg_erp__salesorderheader') }} as salesheader
        left join dim_location
            on salesheader.billtoaddressid = dim_location.addressid
        left join dim_creditcard
            on salesheader.creditcardid = dim_creditcard.creditcardid  
        left join dim_customer
            on salesheader.customerid = dim_customer.customerid
        left join dim_calender
            on salesheader.orderdate = dim_calender.date_day
        left join dim_salesdetails
            on salesheader.salesorderid = dim_salesdetails.salesorderid 
        left join dim_product
            on dim_salesdetails.productid = dim_product.productid    
    )

select * 
from fac_salesorder