{{ config(materialized= 'table') }}

with 
    int_categorys_products as (
        select 
            {{ dbt_utils.generate_surrogate_key(['productcategoryid']) }} as sk_category,
            productcategoryid,
            product_category_name,
            product_subcategory_name
        from {{ ref('int_categorys_products') }}
    ),

    product as (
        select
            productid,
            productsubcategoryid,
            product_name,
            color,
            size,
            productline,
            sellstartdate,
            sellenddate,
            style,
            standardcost,
            listprice,
        from {{ ref('stg_erp__product') }}
    ),

    dim_products as (
        select
            {{ dbt_utils.generate_surrogate_key(['productid']) }} as sk_product,
            p.productid,
            p.product_name,
            p.color,
            p.size,
            p.productline,
            p.sell_start_date,
            p.sell_end_date,
            p.style,
            p.standardcost,
            p.listprice,
            p.product_modified_date,
            cp.sk_category,
            cp.product_category_name,
            cp.product_subcategory_name
        from product p
        left join int_categorys_products cp
            on p.productsubcategoryid = cp.productcategoryid
    )

select *
from dim_products




