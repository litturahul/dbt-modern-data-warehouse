WITH source AS (
  SELECT * FROM {{ source('fivetran_instagram', 'media_history') }}
),

final AS (
  SELECT
    user_id,
    is_story,
    carousel_album_id,
    id,
    ig_id,
    username,
    media_url,
    permalink,
    shortcode,
    thumbnail_url,
    caption,
    is_comment_enabled,
    media_type,
    media_product_type,
    owner_id,
    created_time,
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
