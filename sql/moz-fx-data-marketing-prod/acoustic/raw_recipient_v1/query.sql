BEGIN

    SELECT
        email,
        body_type,
        click_name,
        event_timestamp,
        event_type,
        mailing_id,
        recipient_id,
        recipient_type,
        report_id,
        url,
        suppression_reason,
        @submission_date AS job_date,
        CURRENT_DATETIME() AS loaded_at,

    FROM
        `dev-fivetran.acoustic_sftp.raw_recipient_export`;

    TRUNCATE TABLE `dev-fivetran.acoustic_sftp.raw_recipient_export`;

END;
