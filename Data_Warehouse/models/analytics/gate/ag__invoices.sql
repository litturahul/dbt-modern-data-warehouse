WITH invoices AS (
  SELECT * FROM {{ ref('stg_invoices') }}
),

final AS (
  SELECT
    "InvoiceId" AS invoice_id,
    "CustomerId" AS customer_id,
    "InvoiceDate"::TIMESTAMP AS invoice_at,
    {{ mask_pii('TRIM("BillingAddress")') }} AS address,
    "BillingCity" AS city,
    "BillingState" AS state,
    "BillingCountry" AS country,
    {{ mask_pii('TRIM("BillingPostalCode")') }} AS postal_code,
    "Total"::FLOAT AS total,
    stg_updated_at::TIMESTAMP AS _last_updated_at
  FROM invoices
)

SELECT * FROM final
