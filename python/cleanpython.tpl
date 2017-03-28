{% extends 'python.tpl'%}

## remove markdown cells
{% block markdowncell -%}
{% endblock markdowncell %}

## change the appearance of execution count
{% block in_prompt %}
{%- endblock in_prompt %}
