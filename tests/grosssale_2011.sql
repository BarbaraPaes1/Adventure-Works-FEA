with 
    sales_detail_calculated as (
        select 
            salesorderid
            , (orderqty * unitprice )as gross_sales
        from 
            {{ ref('dim_salesdetails') }}
    )

    , sales_2011 as (
        select 
            sales_detail_calculated.salesorderid
            , sales_detail_calculated.gross_sales
        from 
            sales_detail_calculated 
        join 
            {{ ref('fac_salesorder') }} as salesheader
        on 
            sales_detail_calculated.salesorderid = salesheader.salesorderid
        where 
            extract(year from cast(salesheader.orderdate as datetime)) = 2011
    )

    , gross_sales_2011 as (
        select 
            sum(gross_sales)as actual_gross_sales_2011
        from 
            sales_2011
    )

select 
    *
from 
    gross_sales_2011
where 
    actual_gross_sales_2011 = 12646112.16