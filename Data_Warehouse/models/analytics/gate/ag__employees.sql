WITH employees AS (
  SELECT * FROM {{ ref('stg_employees') }}
),

final AS (
  SELECT
    "EmployeeId" AS employee_id,
    {{ mask_pii('TRIM("FirstName")') }} AS first_name,
    {{ mask_pii('TRIM("LastName")') }} AS last_name,
    "Title" AS title,
    "ReportsTo",
    {{ mask_pii('TRIM("BirthDate")') }} AS birth_date,
    "HireDate" AS hire_date,
    {{ mask_pii('TRIM("Address")') }} AS address,
    "City" AS city,
    "State" AS state,
    "Country" AS country,
    "PostalCode" AS postal_code,
    {{ mask_pii('TRIM("Phone")') }} AS phone,
    {{ mask_pii('TRIM("Fax")') }} AS fax,
    {{ mask_pii('TRIM("Email")') }} AS email,
    stg_updated_at AS _last_updated_at
  FROM employees
)

SELECT * FROM final
