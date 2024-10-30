{{ config(materialized='table') }}

with
    product_category as(
        select
            productcategoryid
            , name as product_category_name
        from {{ ref('stg_erp__productcategory') }}
    ),

    product_subcategory as (
        select
            productsubcategoryid
            , productcategoryid
            , name as product_subcategory_name
        from {{ ref('stg_erp__productsubcategory') }}
    ),

    joined_category_subcategory as (
        select
            pc.ProductCategoryID,
            string_agg(ps.subcategory_name, ', ') as subcategories_agg
        from product_category pc
        left join product_subcategory ps on pc.ProductCategoryID = ps.ProductCategoryID
        group by 
            pc.ProductCategoryID, 
    ),

    int_categorys_products as (
        select 
            {{ dbt_utils.generate_surrogate_key(['ProductCategoryID']) }} as sk_category,
            ProductCategoryID,
            product_category_name,
            product_subcategory_name
        from joined_category_subcategory
    )

select *
from int_categorys_products