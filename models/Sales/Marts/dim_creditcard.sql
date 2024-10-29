version: 2

models:
  - name: dim_creditcard
    columns:
      - name: sk_creditcard
        data_tests:  
          - unique
          - not_null
      - name: creditcardid
        data_tests:  
          - unique
          - not_null        
      - name: businessentityid
        data_tests:  
          - unique
      - name: cardtype
        data_tests:  
          - not_null 