{{
  config(
    materialized='incremental',
    unique_key='id',
    on_schema_change='append_new_columns',
    full_refresh=elementary.get_config_var('elementary_full_refresh'),
    meta={"timestamp_column": "updated_at"},
    table_type="iceberg",
    incremental_strategy="merge"
  )
}}

{{ elementary.empty_data_monitoring_metrics() }}
