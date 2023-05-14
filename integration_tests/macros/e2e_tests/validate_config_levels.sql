{% macro validate_config_levels() %}
    {% set alerts_relation = ref('test_alerts_union') %}

    {% set config_levels_validation_query %}
    with error_tests as (
        select
            table_name, alert_description,
            {{ elementary.contains('tags', 'config_levels') }} as is_config_levels_tag
        from {{ alerts_relation }}
        where status = 'error'
        )
    select table_name, alert_description
    from error_tests
    where is_config_levels_tag = true
    {% endset %}
    {% set results = elementary.agate_to_dicts(run_query(config_levels_validation_query)) | unique | list %}
    {{ assert_lists_contain_same_items(results, []) }}
{% endmacro %}