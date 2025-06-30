{%- set quantative_columns = [
  'spend_cap',
  'min_daily_budget',
  'min_campaign_group_spend_cap',
  'amount_spent',
  'balance',
  'impressions',
  'inline_link_clicks',
  'reach',
  'cost_per_inline_link_click',
  'cpc',
  'cpm',
  'ctr',
  'frequency',
  'spend',
  'inline_link_click_ctr'
] -%}

WITH numerical_columns AS (
  SELECT
    EXTRACT(YEAR FROM date) as _year,
    {% for column in quantative_columns %}
      -- {{ column }}
      {{ descriptive_stats_columns(column) }}{% if not loop.last %}, {% endif %}
    {% endfor %}
  FROM {{ ref('cube_facebook_ads') }}
  WHERE
    date IS NOT NULL
  GROUP BY 1
),

final AS (
  SELECT
    _year,
    column_name,
    min_value,
    max_value,
    mean_value,
    median_value,
    mode_value,
    stddev_value,
    q1_value,
    q3_value,
    (q3_value - q1_value) AS iqr,
    (q1_value - 1.5 * (q3_value - q1_value)) AS lower_bound,
    (q3_value + 1.5 * (q3_value - q1_value)) AS upper_bound
  FROM numerical_columns,
  LATERAL (
    VALUES
      {% for column in quantative_columns %}
        ('{{ column }}', min_{{ column }}, max_{{ column }}, mean_{{ column }}, median_{{ column }}, mode_{{ column }}, stddev_{{ column }}, q1_{{ column }}, q3_{{ column }}){% if not loop.last %},{% endif %}
      {% endfor %}
  ) AS t (
    column_name,
    min_value,
    max_value,
    mean_value,
    median_value,
    mode_value,
    stddev_value,
    q1_value,
    q3_value
  )
)

SELECT * FROM final
