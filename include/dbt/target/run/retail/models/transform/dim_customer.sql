
  
    

    create or replace table `big-data-445013`.`retail`.`dim_customer`
    
    

    OPTIONS()
    as (
      WITH customer_cte AS (
	SELECT DISTINCT
	    to_hex(md5(cast(coalesce(cast(CustomerID as STRING), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(Country as STRING), '_dbt_utils_surrogate_key_null_') as STRING))) as customer_id,
	    Country AS country
	FROM `big-data-445013`.`retail`.`raw_invoices`
	WHERE CustomerID IS NOT NULL
)
SELECT
    t.*,
	cm.iso
FROM customer_cte t
LEFT JOIN `big-data-445013`.`retail`.`country` cm ON t.country = cm.nicename
    );
  