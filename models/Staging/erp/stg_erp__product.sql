with
    product as(
        select
            productid
            , productsubcategoryid
            , name as product_name
            , color
            , size
            , productline
            , DATE(sellstartdate) as sellstartdate
            , DATE(sellenddate) as sellenddate
            , style
            , standardcost
            , listprice
            , modifieddate
        from {{ source('erp_adventureworks','PRODUCT')}}
    )

select *
from product