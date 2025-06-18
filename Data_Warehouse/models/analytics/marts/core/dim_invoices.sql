{{ 
  config(unique_key=["invoice_id"], 
  sort=["invoice_at", "_last_updated_at"])
}}

WITH invoices AS (
  SELECT * FROM {{ ref('ag__invoices') }}
),

final AS (
  SELECT
    invoice_id,
    customer_id,
    invoice_at,
    address,
    city,
    state,
    country,
    postal_code,
    total,
    _last_updated_at
  FROM invoices
)

SELECT * FROM final
{% if is_incremental() %}
WHERE _last_updated_at > (SELECT MAX(_last_updated_at) FROM {{ this }})
{% endif %}
