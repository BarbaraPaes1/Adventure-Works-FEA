with
    creditcard as(
        select
            creditcardid
            , cardtype 
            , modifieddate
        from {{ source('erp_adventureworks','CREDITCARD')}}
    )

select *
from creditcard