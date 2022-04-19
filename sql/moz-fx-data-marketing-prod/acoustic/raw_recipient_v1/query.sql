BEGIN

    SELECT
        email,  -- no nulls  // string
        recipient_id,  -- no nulls  // int
        report_id,  -- no nulls  // int
        mailing_id,  -- no null // int
        PARSE_DATETIME("%m/%d/%Y %H:%M:%S", event_timestamp) AS event_timestamp, -- no nulls  // datetime example: 04/14/2022 12:02:50
        LOWER(COALESCE(event_type, "unknown")) AS event_type, -- no nulls // string
        LOWER(COALESCE(recipient_type, "unknown")) AS recipient_type, -- no nulls // string
        LOWER(COALESCE(body_type, "unknown")) AS body_type, -- 7441275 nulls // string
        LOWER(COALESCE(click_name, "unknown")) AS click_name,  -- 9075718 nulls // string
        COALESCE(url, "unknown") AS url,  -- 9075718 nulls // string
        LOWER(COALESCE(suppression_reason, "unknown")) AS suppression_reason,  -- 8456720 nulls // string
        @submission_date AS job_date, -- // date
        CURRENT_DATETIME() AS processed_at, -- // datetime

    FROM
        `dev-fivetran.acoustic_sftp.raw_recipient_export`;  -- TODO: update dataaset to prod dataset

    TRUNCATE TABLE `dev-fivetran.acoustic_sftp.raw_recipient_export`;  -- TODO: update dataaset to prod dataset

END;
