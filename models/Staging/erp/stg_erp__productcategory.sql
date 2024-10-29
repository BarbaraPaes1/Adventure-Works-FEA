with
    product_category as(
        select
            productcategoryid
            , name as product_category_name
            , modifieddate
        from{{ source('erp_adventureworks','PRODUCTCATEGORY')}}
    )

select *
from product_category