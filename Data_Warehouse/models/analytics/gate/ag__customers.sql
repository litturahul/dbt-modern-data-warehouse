WITH customers AS (
  SELECT * FROM {{ ref('stg_customers') }}
),

final AS (
  SELECT
    "CustomerId" AS customer_id,
    {{ mask_pii('TRIM("FirstName")') }} AS first_name,
    {{ mask_pii('TRIM("LastName")') }} AS last_name,
    "Company" AS company,
    {{ mask_pii('TRIM("Address")') }} AS "address",
    "City" AS city,
    "State" AS "state",
    "Country" AS country,
    "PostalCode" AS postal_code,
    {{ mask_pii('TRIM("Phone")') }} AS phone,
    {{ mask_pii('TRIM("Fax")') }} AS fax,
    {{ mask_pii('TRIM("Email")') }} AS email,
    "SupportRepId" AS support_rep_id,
    "stg_updated_at"::TIMESTAMP AS _last_updated_at
  FROM customers
)

SELECT * FROM final
