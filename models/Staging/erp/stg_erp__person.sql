with
    person as (
        select
            cast(businessentityid as int) as businessentityid,
            persontype,
            firstname,
            middlename,
            lastname,
            firstname || ' ' || middlename || ' ' || lastname as full_name,
            modifieddate
        from {{ source('erp_adventureworks', 'PERSON') }}
    )

select *
from person