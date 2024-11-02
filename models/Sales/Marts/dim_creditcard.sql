{{ config(materialized='table') }}

with
    creditcard as (
        select
            creditcardid,
            cardtype,
            modifieddate
        from {{ ref('stg_erp__creditcard') }}
    ),

    person_credit_card as (
        select
            creditcardid,
            businessentityid
        from {{ ref('stg_erp__personcreditcard') }}
    ),

    person as (
        select
            businessentityid,
            cast(firstname || ' ' || middlename || ' ' || lastname as varchar) as full_name
        from {{ ref('stg_erp__person') }}
    ),

    joined_data as (
        select
            cc.creditcardid,
            cc.cardtype,
            cc.modifieddate as creditcard_modifieddate,
            pcc.businessentityid,
            p.full_name
        from creditcard cc
        join person_credit_card pcc on cc.creditcardid = pcc.creditcardid
        join person p on pcc.businessentityid = p.businessentityid
    ),

    dim_creditcard as (
        select 
            {{ dbt_utils.generate_surrogate_key(['creditcardid']) }} as sk_creditcard,
            *
        from joined_data
    )

select *
from dim_creditcard




