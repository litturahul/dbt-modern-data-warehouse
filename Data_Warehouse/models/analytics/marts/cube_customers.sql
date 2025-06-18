{{ 
  config(unique_key=["customer_id"], 
  sort=["max_updated_at"])
}}

WITH customers AS (
  SELECT * FROM {{ ref('dim_customers') }}
),

invoices AS (
  SELECT
    customer_id,
    COUNT(invoice_id) AS invoice_count,
    SUM(total) AS total_spent,
    MAX(invoice_at) AS last_invoice_date
  FROM {{ ref('dim_invoices') }}
  GROUP BY 1
),

final AS (
  SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.email,
    customers.phone,
    customers.address,
    customers.city,
    customers.state,
    customers.country,
    customers.postal_code,
    invoices.invoice_count,
    invoices.total_spent,
    GREATEST(
      invoices.last_invoice_date,
      customers._last_updated_at
    ) AS max_updated_at
  FROM customers
  LEFT JOIN invoices
    ON
      customers.customer_id = invoices.customer_id
)

SELECT * FROM final
{% if is_incremental() %}
WHERE max_updated_at > (SELECT MAX(max_updated_at) FROM {{ this }})
{% endif %}