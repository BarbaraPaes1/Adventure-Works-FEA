{{ config(materialized='table') }}

with
    product_category as(
        select
            productcategoryid,
            product_category_name
        from {{ ref('stg_erp__productcategory') }}
    ),

    product_subcategory as (
        select
            productsubcategoryid,
            productcategoryid,
            product_subcategory_name
        from {{ ref('stg_erp__productsubcategory') }}
    ),

    joined_category_subcategory as (
        select
            pc.productcategoryid,
            pc.product_category_name,
            LISTAGG(ps.product_subcategory_name, ', ') as subcategories_agg
        from product_category pc
        left join product_subcategory ps on pc.productcategoryid = ps.productcategoryid
        group by 
            pc.productcategoryid
         ,  pc.product_category_name
    ),

    int_categorys_products as (
        select 
            {{ dbt_utils.generate_surrogate_key(['productcategoryid']) }} as sk_category,
            productcategoryid,
            product_category_name,
            subcategories_agg as product_subcategory_name
        from joined_category_subcategory
    )

select *
from int_categorys_products
