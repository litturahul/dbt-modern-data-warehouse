WITH source AS (
  SELECT * FROM {{ source('fivetran_instagram', 'media_insights') }}
),

final AS (
  SELECT
    id,
    like_count,
    comment_count,
    video_photo_impressions,
    video_photo_reach,
    video_photo_saved,
    video_photo_views,
    video_photo_shares,
    carousel_album_engagement,
    carousel_album_impressions,
    carousel_album_reach,
    carousel_album_saved,
    carousel_album_views,
    carousel_album_shares,
    story_impressions,
    story_reach,
    story_views,
    story_shares,
    navigation,
    reel_reach,
    reel_saved,
    reel_views,
    reel_shares,
    video_photo_engagement,
    story_exits,
    story_replies,
    story_taps_back,
    story_taps_forward,
    story_swipe_forward,
    reel_comments,
    reel_likes,
    reel_total_interactions,
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
