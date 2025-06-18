{% test rows_fewer_than(model, threshold, target_env) %}

WITH validation as (

    {% if target.name == target_env %}

    SELECT
        COUNT(*) AS total_rows

    FROM {{ model }}

    {% else %}

    SELECT
        0 AS total_rows

    {% endif %}

),

validation_errors AS (

    SELECT
        total_rows

    FROM validation
    -- if this is true, then total number of records are more than the threshold!
    WHERE total_rows >= {{ threshold }}

)

SELECT *
FROM validation_errors

{% endtest %}