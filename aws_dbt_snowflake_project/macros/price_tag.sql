{% macro price_tag(price_col) %}
    case 
        when {{ price_col }} < 100 then 'LOW'
        when {{ price_col }} < 200 then 'MEDIUM'
        else 'HIGH'
    end
{% endmacro %}