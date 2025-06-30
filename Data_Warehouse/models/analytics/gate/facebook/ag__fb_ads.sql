WITH source AS (
  SELECT * FROM {{ source('fivetran_facebook', 'basic_ad') }}
),

final AS (
  SELECT
    ad_id::BIGINT AS ad_id,
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
    ad_name,
    adset_name,
    inline_link_click_ctr::FLOAT AS inline_link_click_ctr,
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
