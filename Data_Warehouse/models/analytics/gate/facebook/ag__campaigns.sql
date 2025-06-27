WITH source AS (
  SELECT * FROM {{ source('fivetran_facebook', 'basic_campaign') }}
),

final AS (
  SELECT
    campaign_id,
    "date",
    account_id,
    campaign_name,
    impressions,
    inline_link_clicks,
    reach,
    cost_per_inline_link_click,
    cpc,
    cpm,
    ctr,
    frequency,
    spend,
    inline_link_click_ctr,
    "_fivetran_id",
    "_fivetran_synced"
  FROM source
)

SELECT * FROM final
