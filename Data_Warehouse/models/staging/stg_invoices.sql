WITH source AS (
  SELECT * FROM {{ source('music', 'invoice') }}
),

final AS (
  SELECT
    *,
    NOW() AS stg_updated_at
  FROM source
)

SELECT * FROM final
