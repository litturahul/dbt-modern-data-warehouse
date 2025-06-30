WITH accounts AS (
  SELECT * FROM {{ ref('ag__fb_account_history') }}
),

facebook_ads AS (
  SELECT * FROM {{ ref('ag__fb_ads') }}
),

final AS (
  SELECT
    accounts.account_id,
    -- Account Details
    accounts.account_name,
    accounts.account_status,
    accounts.disable_reason,
    accounts.timezone_id,
    accounts.timezone_name,
    accounts.timezone_offset_hours_utc,
    accounts.business_name,
    -- Demographic Details
    accounts.business_street,
    accounts.business_street_2,
    accounts.business_zip,
    accounts.business_city,
    accounts.business_state,
    accounts.business_country_code,
    -- Financial Details
    accounts.spend_cap,
    accounts.min_daily_budget,
    accounts.min_campaign_group_spend_cap,
    COALESCE(accounts.amount_spent, 0) AS amount_spent,
    COALESCE(accounts.balance, 0) AS balance,
    accounts.currency,
    accounts.tax_id,
    accounts.tax_id_status,
    -- Facebook Ads Details
    facebook_ads.ad_id,
    facebook_ads.adset_name,
    facebook_ads.ad_name,
    facebook_ads.date,
    COALESCE(facebook_ads.impressions, 0) AS impressions,
    COALESCE(facebook_ads.inline_link_clicks, 0) AS inline_link_clicks,
    COALESCE(facebook_ads.reach, 0) AS reach,
    COALESCE(facebook_ads.cost_per_inline_link_click, 0) AS cost_per_inline_link_click,
    COALESCE(facebook_ads.cpc, 0) AS cpc,
    COALESCE(facebook_ads.cpm, 0) AS cpm,
    COALESCE(facebook_ads.ctr, 0) AS ctr,
    COALESCE(facebook_ads.frequency, 0) AS frequency,
    COALESCE(facebook_ads.spend, 0) AS spend,
    COALESCE(facebook_ads.inline_link_click_ctr, 0) AS inline_link_click_ctr
  FROM accounts
  LEFT JOIN facebook_ads
    ON
      accounts.account_id = facebook_ads.account_id
)

SELECT * FROM final
