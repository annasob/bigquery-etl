-- Generated by ./bqetl generate events_daily
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.event_types`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.event_types_v1`
