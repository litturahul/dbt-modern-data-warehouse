WITH source AS (
  SELECT * FROM {{ source('fivetran_facebook', 'basic_ad_set') }}
),

final AS (
  SELECT
    adset_id::BIGINT AS adset_id,
    "date",
    account_id,
    impressions,
    inline_link_clicks,
    reach,
    cost_per_inline_link_click,
    cpc,
    cpm,
    ctr,
    frequency,
    spend,
    adset_name,
    campaign_name,
    inline_link_click_ctr::FLOAT AS inline_link_click_ctr,
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
