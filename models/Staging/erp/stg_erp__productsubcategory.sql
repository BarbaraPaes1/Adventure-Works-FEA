with
    product_subcategory as(
        select
            productsubcategoryid
            , productcategoryid
            , name as product_subcategory_name
            , modifieddate
        from {{ source('erp_adventureworks','PRODUCTSUBCATEGORY')}}
    )

select *
from product_subcategory