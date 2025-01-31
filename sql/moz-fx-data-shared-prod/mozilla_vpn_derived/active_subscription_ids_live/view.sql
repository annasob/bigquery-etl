CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn_derived.active_subscription_ids_live`
AS
SELECT
  active_date,
  subscription_id,
FROM
  mozdata.mozilla_vpn.all_subscriptions
CROSS JOIN
  UNNEST(GENERATE_DATE_ARRAY(DATE(subscription_start_date), DATE(end_date) - 1)) AS active_date
