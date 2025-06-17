{% macro mask_pii(field_name, method='sha256') %}
  {%- if method == 'sha256' -%}
    encode(digest('spice it up with some salt' || {{ field_name }}, 'sha256'), 'hex')
  {%- endif -%}
{% endmacro %}