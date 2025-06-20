{{ 
  config(unique_key=["customer_id"], 
  sort=["_last_updated_at"])
}}

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
{% if is_incremental() %}
WHERE _last_updated_at > (SELECT MAX(_last_updated_at) FROM {{ this }})
{% endif %}