with
    product as(
        select
            productid
            , productsubcategoryid
            , name as product_name
            , color
            , size
            , productline
            , style
            , standardcost
            , listprice
            , modifieddate
        from{{ source('erp_adventureworks','PRODUCT')}}
    )

select *
from product