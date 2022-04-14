BEGIN
    SELECT
        *,  -- if new fields are added this should break and require to manual schema change
        @submission_date AS submission_date,

    FROM
        `dev-fivetran.acoustic_sftp.raw_recipient_export`;

    TRUNCATE TABLE IF EXISTS `dev-fivetran.acoustic_sftp.raw_recipient_export`;

END;
