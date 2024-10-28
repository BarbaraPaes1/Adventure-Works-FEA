with
    person as(
        select
            businessentityid
            , persontype
            , firstname
            , middlename
            , lastname
            , modifieddate
        from{{ source('erp_adventureworks','person')}}
    )

select *
from person