WITH source AS (
  SELECT * FROM {{ source('fivetran_instagram', 'user_history') }}
)

final AS (
  SELECT
    id,
    ig_id,
    follows_count,
    followers_count,
    media_count,
    "name",
    username,
    website,
    has_profile_pic,
    profile_picture_url,
    is_published,
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
