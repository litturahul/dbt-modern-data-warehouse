WITH source AS (
  SELECT * FROM {{ source('fivetran_instagram', 'media_comment') }}
),

final AS (
  SELECT
    media_id,
    hidden,
    id,
    like_count,
    parent_id,
    "text",
    owner_id,
    owner_username,
    created_time,
    "_fivetran_id",
    "_fivetran_synced"
  FROM final
)

SELECT * FROM final
