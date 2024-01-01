use database "DEMO_DATABASE";

DESCRIBE TABLE AJ_CONSUMER_COMPLAINTS;

select * from AJ_CONSUMER_COMPLAINTS LIMIT 100; --TOP WORKS IN MYSQL

SELECT DISTINCT * FROM AJ_CONSUMER_COMPLAINTS;

select distinct CONSUMER_DISPUTED from AJ_CONSUMER_COMPLAINTS;

--SYNTAX : SELECT DISTINCT COL_NAME FROM TABLE_NAME
SELECT DISTINCT PRODUCT_NAME FROM AJ_CONSUMER_COMPLAINTS;
SELECT DISTINCT SUB_PRODUCT FROM AJ_CONSUMER_COMPLAINTS;

SELECT DISTINCT ISSUE FROM AJ_CONSUMER_COMPLAINTS;

select distinct COMPANY from AJ_CONSUMER_COMPLAINTS;
SELECT DISTINCT SUBMITTED_VIA  from AJ_CONSUMER_COMPLAINTS;

--to selecvt all the columns
--then am filtering rows based on the conditions 
SELECT DATE_RECEIVED, PRODUCT_NAME ,SUB_PRODUCT,ISSUE,
        CASE WHEN SUBMITTED_VIA IN ('Referral','Postal Mail','Email') THEN 'Outbound'
             WHEN SUBMITTED_VIA IN ('Phone','Web') THEN 'Inbound'
             ELSE 'Electronics'
         END AS Submission_Type,
         
         COMPANY,STATE_NAME,ZIP_CODE
         
FROM AJ_CONSUMER_COMPLAINTS;


select *, case
when SUBMITTED_VIA in ('Phone' ,'Web') then 'INBOard',
when SUBMITTED_VIA = 'Fax' then 'Electronic',
else 'outboard'
end as Submission_type;


SELECT DISTINCT COMPANY_RESPONSE_TO_CONSUMER FROM AJ_CONSUMER_COMPLAINTS;

-----CODE 
select *,
    CASE 
        wHen Product_Name like '%loan%' or Product_Name like '%Loan%' then 'Loan type'--THIS U CAN AVOIUD 
        when Product_Name in ('Bank account or service','Mortgage','Debt collection', 
                              'Credit reporting','Money transfers') then 'service'
        else 'other'
        
    end as Finance_type 
    from AJ_CONSUMER_COMPLAINTS;
    
    
    ----- OPTIMIZED CODE
    SELECT *,
               CASE 
	                WHEN LOWER(PRODUCT_NAME) LIKE '%loan' THEN 'Loan'
	                WHEN UPPER(PRODUCT_NAME) IN('BANK ACCOUNT OR SERVICE','MORTGAGE','DEBT CLLECTION','CREDIT CARD','CREDIT REPORTING','MONEY TRANSFERS') THEN 'Service'
	ELSE 'Other'
END AS FINANCE_TYPE
FROM AJ_CONSUMER_COMPLAINTS;

select  *,
    case when product_name like '%loan' or product_name like '%Loan' then 'loan'
         when product_name in ('Mortage','Bank account or service then','Credit reporting') then 'Service'
    else 'Others'
    end as finance_type
  from AJ_CONSUMER_COMPLAINTS;

 --bhanu code   
SELECT *,
        CASE
        WHEN PRODUCT_NAME LIKE '%Loan%' OR PRODUCT_NAME LIKE '%loan%' THEN 'LOAN'
        WHEN PRODUCT_NAME IN ('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting',
                              'Money transfers','Prepaid card') THEN 'SERVICE'
        ELSE 'OTHER'
        END AS TYPE
FROM AJ_CONSUMER_COMPLAINTS;


SELECT *,
	CASE
	WHEN SUB_PRODUCT = 'I do not know' or SUB_PRODUCT is null THEN 'NA'
	WHEN lower(SUB_PRODUCT) LIKE '%loan' THEN 'LOAN'
	WHEN lower(SUB_PRODUCT) LIKE '%card' THEN 'CARD'
	WHEN lower(SUB_PRODUCT) LIKE '%mortage' THEN 'MORTGAGE'
	ELSE SUB_PRODUCT
    END AS SUB_PRODUCT_TYPE
FROM AJ_CONSUMER_COMPLAINTS;

--AAMIR
SELECT *,
case
    when lower(sub_product) like '%loan%' then 'LOAN'
    when lower(sub_product) like '%card%' then 'CARD'
    when lower(sub_product) like '%mortage%' then 'MORTAGE'
    when sub_product ='I do not know' or sub_product is NULL  then 'NA'
    else sub_product
    end as subproduct_type
    from AJ_CONSUMER_COMPLAINTS;


--suraj 
select *, 
                case 
                          when SUB_PRODUCT = 'I do not know' or SUB_PRODUCT is NULL THEN 'NA'
                          when lower (SUB_PRODUCT) LIKE '%loan' THEN 'LOAN'
                          when lower (SUB_PRODUCT) LIKE  '%card' THEN 'CARD'
                          when lower (SUB_PRODUCT) LIKE '%mortgage' THEN 'MORTGAGE'
                          
                         ELSE SUB_PRODUCT
                         END AS SUB_PRODUCT_TYPE
               FROM  aj_CONSUMER_COMPLAINTS;

--aamir
     CASE
         WHEN lower(SUB_PRODUCT)IN '%mortgage' THEN 'MORTGAGE'
         WHEN SUB_PRODUCT IN 'I do not know' OR SUB_PRODUCT IS NULL THEN NOT 'SPECIFIED'
         
         ELSE SUB_PRODUCT
         
         END AS ABCD
         
         
         FROM AM_CONSUMER_COMPLAINTS;

CREATE OR REPLACE VIEW  AJ_COMPANY_RESPONSE_TO_CONSUMER AS
SELECT DATE_RECEIVED,PRODUCT_NAME,SUB_PRODUCT,ISSUE,COMPANY,STATE_NAME,ZIP_CODE,SUBMITTED_VIA,

         CASE WHEN SUBMITTED_VIA IN ('Referral','Postal Mail','Email') THEN 'Outbound'
              WHEN SUBMITTED_VIA IN ('Phone','Web') THEN 'Inbound'
             ELSE 'Electronics'
         END AS Submission_Type,
         
         case 
               when SUB_PRODUCT = 'I do not know' or SUB_PRODUCT is NULL THEN 'NA'
               when lower (SUB_PRODUCT) LIKE '%loan' THEN 'LOAN'
               when lower (SUB_PRODUCT) LIKE  '%card' THEN 'CARD'
               when lower (SUB_PRODUCT) LIKE '%mortgage' THEN 'MORTGAGE'
               ELSE SUB_PRODUCT
         END AS SUB_PRODUCT_TYPE,
         
         CASE 
             WHEN COMPANY_RESPONSE_TO_CONSUMER = 'Closed with explanation' THEN 'Explained'
             WHEN COMPANY_RESPONSE_TO_CONSUMER = 'Closed with monetary relief' THEN 'Monetary releif provided'
             WHEN COMPANY_RESPONSE_TO_CONSUMER LIKE '%Closed%' THEN 'Closed'
             ELSE COMPANY_RESPONSE_TO_CONSUMER
        END AS COMPANY_RESPONSE_CONSUMER_TYPE
        
FROM AJ_CONSUMER_COMPLAINTS;

SELECT * FROM AJ_COMPANY_RESPONSE_TO_CONSUMER;