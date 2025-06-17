WITH source AS (
  SELECT * FROM {{ source('music', 'customers') }}
),

final AS (
  SELECT
    *,
    NOW() AS stg_updated_at
  FROM source
)

SELECT * FROM final
