{{ config(materialized= 'table') }} 
 
 
 
    int_categorys_products as (
        select 
            {{ dbt_utils.generate_surrogate_key(['ProductCategoryID']) }} as sk_category,
            ProductCategoryID,
            product_category_name,
            product_subcategory_name
        from {{ ref('int_categorys_products') }}
    ),

    product as(
        select
            productid
            , productsubcategoryid
            , name as product_name
            , color
            , size
            , productline
            , DATE(sellstartdate)
            , DATE(sellenddate)
            , style
            , standardcost
            , listprice
            , modifieddate
        from {{ ref('stg_erp__product') }}
    ),

    dim_products as (
        select
            {{ dbt_utils.generate_surrogate_key(['ProductID', 'ProductCategoryID']) }} as sk_product,
            p.ProductID,
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
            on p.ProductCategoryID = cp.ProductCategoryID
    )

select *
from dim_products



select *
from dim_products