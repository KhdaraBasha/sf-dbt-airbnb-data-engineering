{% macro standardize_string(column_name) %}
    nullif(upper(trim({{ column_name }})), '')
{% endmacro %}