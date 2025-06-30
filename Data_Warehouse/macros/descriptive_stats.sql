-- This macro generates descriptive statistics for a given field in a table.
-- It calculates the minimum, maximum, mean, median, mode, standard deviation,
-- and the first and third quartiles (Q1 and Q3).

{%- macro descriptive_stats_columns(field_name) -%}
  
  MIN({{ field_name }}) AS min_{{ field_name }},
  MAX({{ field_name }}) AS max_{{ field_name }},
  AVG({{ field_name }}) AS mean_{{ field_name }},
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY {{ field_name }}) AS median_{{ field_name }},
  mode() WITHIN GROUP (ORDER BY {{ field_name }}) AS mode_{{ field_name }},
  STDDEV({{ field_name }}) AS stddev_{{ field_name }},
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY {{ field_name }}) AS q1_{{ field_name }},
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY {{ field_name }}) AS q3_{{ field_name }}

{%- endmacro -%}