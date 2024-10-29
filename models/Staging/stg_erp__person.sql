with
    person as(
        select
            cast(businessentityid as int)
            , persontype
            , firstname
            , middlename
            , lastname
            , cast(firstname || ' ' || middlename || ' ' || lastname) as full_name
            , modifieddate
        from{{ source('erp_adventureworks','PERSON')}}
    )

select *
from person