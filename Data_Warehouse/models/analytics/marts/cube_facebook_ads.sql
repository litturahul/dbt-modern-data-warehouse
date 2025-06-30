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
    accounts.amount_spent,
    accounts.balance,
    accounts.currency,
    accounts.tax_id,
    accounts.tax_id_status,
    -- Facebook Ads Details
    facebook_ads.ad_id,
    facebook_ads.adset_name,
    facebook_ads.ad_name,
    facebook_ads.date,
    facebook_ads.impressions,
    facebook_ads.inline_link_clicks,
    facebook_ads.reach,
    facebook_ads.cost_per_inline_link_click,
    facebook_ads.cpc,
    facebook_ads.cpm,
    facebook_ads.ctr,
    facebook_ads.frequency,
    facebook_ads.spend,
    facebook_ads.inline_link_click_ctr
  FROM accounts
  LEFT JOIN facebook_ads
    ON
      accounts.account_id = facebook_ads.account_id
)

SELECT * FROM final
