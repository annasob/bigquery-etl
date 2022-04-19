CREATE TEMP FUNCTION FORMAT_FXA_DATE(date_string STRING)
  RETURNS DATE
  AS (
      CASE
      WHEN REGEXP_CONTAINS(date_string, r"^(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{1,3}Z)$")
        THEN DATE(DATETIME(SPLIT(date_string, ".")[OFFSET(0)]))
      WHEN REGEXP_CONTAINS(date_string, r"^(\d{2}/\d{2}/\d{4})$")
        THEN PARSE_DATE("%m/%d/%Y", date_string)
      ELSE
        DATE(date_string)
      END
  );

BEGIN

    SELECT
        -- LOWER(email),  -- do we actually need email? Looks like we could use email_id as a unique identifier? -- not null // string
        email_id,  -- not null // string
        basket_token,  -- 8729 so far with null values | is this a problem?  // string
        sfdc_id,  -- 1142993 so far with null values | is this a problem?  // string
        fxa_id,  -- 121606 nulls || this is bad?

        CAST(COALESCE(double_opt_in, 0) AS BOOLEAN) AS double_opt_in,  -- no nulls, true or false value  // boolean
        CAST(COALESCE(has_opted_out_of_email, 0) AS BOOLEAN) AS has_opted_out_of_email,  -- int, no nulls, true or false value  // boolean

        LOWER(COALESCE(email_lang, "unknown")) AS email_lang, --  6126 nulls, and case differences  // string
        LOWER(email_format) AS email_format,  -- no nulls, CHAR (T OR H)  // string
        LOWER(COALESCE(mailing_country, "unknown")) AS mailing_country,  -- no nulls  // string
        LOWER(COALESCE(cohort, "unknown")) AS cohort,  -- 1320918 nulls

        FORMAT_FXA_DATE(fxa_created_date) AS fxa_created_date,  -- 107057 nulls  -- need to parse the date
        LOWER(COALESCE(fxa_first_service, "unknown")) AS fxa_first_service,  -- no nulls  // string
        CAST(COALESCE(fxa_account_deleted, 0) AS BOOLEAN) AS fxa_account_deleted,  -- 77207 nulls // boolean but contains nulls | how should they be treated?

        CAST(COALESCE(sub_mozilla_foundation, 0) AS BOOLEAN) AS sub_mozilla_foundation,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_common_voice, 0) AS BOOLEAN) AS sub_common_voice,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_hubs, 0) AS BOOLEAN) AS sub_hubs,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_mixed_reality, 0) AS BOOLEAN) AS sub_mixed_reality,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_internet_health_report, 0) AS BOOLEAN) AS sub_internet_health_report,  -- # nulls  // boolean
        CAST(COALESCE(sub_miti, 0) AS BOOLEAN) AS sub_miti,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_mozilla_fellowship_awardee_alumni, 0) AS BOOLEAN) AS sub_mozilla_fellowship_awardee_alumni,  -- # nulls  // boolean
        CAST(COALESCE(sub_mozilla_festival, 0) AS BOOLEAN) AS sub_mozilla_festival,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_mozilla_technology, 0) AS BOOLEAN) AS sub_mozilla_technology,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_mozillians_nda, 0) AS BOOLEAN) AS sub_mozillians_nda,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_firefox_accounts_journey, 0) AS BOOLEAN) AS sub_firefox_accounts_journey,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_knowledge_is_power, 0) AS BOOLEAN) AS sub_knowledge_is_power,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_take_action_for_the_internet, 0) AS BOOLEAN) AS sub_take_action_for_the_internet,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_test_pilot, 0) AS BOOLEAN) AS sub_test_pilot,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_firefox_news, 0) AS BOOLEAN) AS sub_firefox_news,  -- 2 nulls  // boolean
        CAST(COALESCE(sub_about_mozilla, 0) AS BOOLEAN) AS sub_about_mozilla,  -- 13436 nulls  // boolean
        CAST(COALESCE(sub_apps_and_hacks, 0) AS BOOLEAN) AS sub_apps_and_hacks,  -- 12988 nulls  // boolean
        CAST(COALESCE(sub_rally, 0) AS BOOLEAN) AS sub_rally,  -- 13641 nulls  // boolean
        CAST(COALESCE(sub_firefox_sweepstakes, 0) AS BOOLEAN) AS sub_firefox_sweepstakes,  -- 14226 nulls  // boolean

        -- TODO: assuming 0 for us means false which means NOT subscribed

        LOWER(vpn_waitlist_geo) AS vpn_waitlist_geo,  -- 1221463 nulls, contains case diffences  // no_value is a bad choice of default, should this just be null?
        SPLIT(vpn_waitlist_platform, ",") AS vpn_waitlist_platform,  -- 1230937 nulls, single field contains multiple values comma separated, should this be a repeated field?  // repeated string field
        -- relay_waitlist_geo,  -- # missing field, need to verify, maybe it's related to reusing old connector
        -- recipient_id,  -- 1326878 nulls, a field coming from Acoustic, shoudl this field be excluded?
        last_modified_date,  -- 1326878 nulls, acoustic field
        @submission_date AS job_date,  -- // date
        CURRENT_DATETIME() AS processed_at, --  //  datetime

    FROM
        `dev-fivetran.acoustic_sftp.contact_export`;  -- TODO: update dataaset to prod dataset

    TRUNCATE TABLE `dev-fivetran.acoustic_sftp.contact_export`;  -- TODO: update dataaset to prod dataset

END;
