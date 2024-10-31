with
    person as (
        select
            businessentityid,
            persontype,
            firstname,
            middlename,
            lastname,
            firstname || ' ' || middlename || ' ' || lastname as fullname,
            modifieddate
        from {{ source('erp_adventureworks', 'PERSON') }}
    )

select *
from person