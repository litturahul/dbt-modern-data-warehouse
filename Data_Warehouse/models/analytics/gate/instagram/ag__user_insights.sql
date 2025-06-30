WITH source AS (
  SELECT * FROM {{ source('fivetran_instagram', 'user_insights') }}
),

final AS (
  SELECT
    id,
    "date",
    follower_count,
    unfollower_count,
    reach,
    reach_7_d,
    reach_28_d,
    "comments",
    likes,
    replies,
    saves,
    shares,
    total_interactions,
    "views",
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
