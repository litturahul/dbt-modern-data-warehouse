WITH facebook_ads AS (
  SELECT * FROM {{ ref('cube_facebook_ads') }}
),

adsets AS (
  SELECT DISTINCT
    account_id,
    adset_id,
    adset_name,
    campaign_name
  FROM {{ ref('ag__fb_ad_sets') }}
),

final AS (
  SELECT
    facebook_ads.account_id,
    -- Account Details
    facebook_ads.account_name,
    facebook_ads.account_status,
    adsets.campaign_name,
    facebook_ads.adset_name,
    -- Timeline of Advertising
    MIN(facebook_ads.date) AS advertising_start_date,
    MAX(facebook_ads.date) AS advertising_end_date,
    -- Campaign Performance Metrics
    SUM(facebook_ads.spend) AS total_spend,
    AVG(facebook_ads.frequency) AS avg_frequency,
    SUM(facebook_ads.reach) AS total_reach,
    SUM(facebook_ads.impressions) AS total_impressions,
    -- Click Performance Metrics
    AVG(facebook_ads.cpc) AS avg_cpc,
    AVG(facebook_ads.cpm) AS avg_cpm,
    AVG(facebook_ads.ctr) AS avg_ctr,
    -- Inline Click Performance Metrics
    AVG(facebook_ads.cost_per_inline_link_click) AS avg_cost_per_inline_link_click,
    SUM(facebook_ads.inline_link_clicks) AS total_inline_link_clicks,
    AVG(facebook_ads.inline_link_click_ctr) AS avg_inline_link_click_ctr
  FROM facebook_ads
  LEFT JOIN adsets
    ON
      facebook_ads.account_id = adsets.account_id
      AND facebook_ads.adset_name = adsets.adset_name
  GROUP BY 1, 2, 3, 4, 5
)

SELECT * FROM final
