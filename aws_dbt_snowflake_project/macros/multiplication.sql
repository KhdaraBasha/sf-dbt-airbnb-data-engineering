{% macro multiply_numbers(a, b, precision) %}
    round({{ a }} * {{ b }}, {{ precision }})
{% endmacro %}