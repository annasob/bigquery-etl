BEGIN

    SELECT
        email,
        basket_token,
        sfdc_id,
        double_opt_in,
        has_opted_out_of_email,
        email_format,
        email_lang,
        fxa_created_date,
        fxa_first_service,
        fxa_id,
        fxa_account_deleted,
        email_id,
        mailing_country,
        cohort,
        sub_mozilla_foundation,
        sub_common_voice,
        sub_hubs,
        sub_mixed_reality,
        sub_internet_health_report,
        sub_miti,
        sub_mozilla_fellowship_awardee_alumni,
        sub_mozilla_festival,
        sub_mozilla_technology,
        sub_mozillians_nda,
        sub_firefox_accounts_journey,
        sub_knowledge_is_power,
        sub_take_action_for_the_internet,
        sub_test_pilot,
        sub_firefox_news,
        vpn_waitlist_geo,
        vpn_waitlist_platform,
        sub_about_mozilla,
        sub_apps_and_hacks,
        sub_rally,
        sub_firefox_sweepstakes,
        relay_waitlist_geo,
        recipient_id,
        last_modified_date,
        @submission_date AS ,
        CURRENT_DATETIME() AS loaded_at,

    FROM
        `dev-fivetran.acoustic_sftp.raw_recipient_export`;

    TRUNCATE TABLE `dev-fivetran.acoustic_sftp.raw_recipient_export`;

END;
