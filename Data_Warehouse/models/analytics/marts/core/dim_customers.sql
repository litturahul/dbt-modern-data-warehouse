WITH customers AS (
  SELECT * FROM {{ ref('ag__customers') }}
),

final AS (
  SELECT
    customer_id,
    first_name,
    last_name,
    company,
    address,
    city,
    state,
    country,
    postal_code,
    phone,
    fax,
    email,
    support_rep_id,
    _last_updated_at
  FROM customers
)

SELECT * FROM final
