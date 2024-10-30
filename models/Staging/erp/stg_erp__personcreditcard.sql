with
    person_credit_card as(
        select
            creditcardid
            , businessentityid
        from {{ source('erp_adventureworks','PERSONCREDITCARD')}}
    )

select *
from person_credit_card