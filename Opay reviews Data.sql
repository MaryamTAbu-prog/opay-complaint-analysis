DROP TABLE IF EXISTS opay_categorised;

SELECT
    TRY_CAST([date] AS datetime2) AS review_date,
    rating,
    review,
    CASE
        WHEN review LIKE '%notification%' OR review LIKE '%alert%' OR review LIKE '%promotion%'
            THEN 'Notifications and alerts'
        WHEN review LIKE '%verif%' OR review LIKE '%kyc%' OR review LIKE '%bvn%' OR review LIKE '%camera%'
             OR review LIKE '%finger%' OR review LIKE '%biometric%' OR review LIKE '%face id%'
             OR review LIKE '%activation%' OR review LIKE '%registration%'
             OR review LIKE '%access my%' OR review LIKE '%unable to access%' OR review LIKE '%not allowed%'
             OR review LIKE '%delete my%'
             OR review LIKE '%can not use%' OR review LIKE '%cannot use%' OR review LIKE '%can''t use%'
             OR review LIKE '%cant use%' OR review LIKE '%can''t log%' OR review LIKE '%cannot log%'
            THEN 'Verification, login or access'
        WHEN review LIKE '%not received%' OR review LIKE '%didn''t receive%' OR review LIKE '%did not receive%'
             OR review LIKE '%not reflect%' OR review LIKE '%pending%' OR review LIKE '%failed%'
             OR review LIKE '%not credited%' OR review LIKE '%never arrived%'
             OR review LIKE '%didn''t see%' OR review LIKE '%not see my%' OR review LIKE '%not seen%'
             OR review LIKE '%didn''t get%' OR review LIKE '%did not get%' OR review LIKE '%didn''t enter%'
             OR review LIKE '%no transfer%'
             OR review LIKE '%can''t transfer%' OR review LIKE '%cannot transfer%'
             OR review LIKE '%cant transfer%' OR review LIKE '%can not transfer%' OR review LIKE '%can''t not transfer%'
            THEN 'Failed or missing transfer'
        WHEN review LIKE '%deduct%' OR review LIKE '%removed%' OR review LIKE '%removal%'
             OR review LIKE '%took my%' OR review LIKE '%took %from%' OR review LIKE '%refund%'
             OR review LIKE '%refound%' OR review LIKE '%debited%' OR review LIKE '%revers%'
             OR review LIKE '%recall%'
            THEN 'Money deducted or refund'
        WHEN review LIKE '%charge%' OR review LIKE '% fee%'
            THEN 'Fees and charges'
        WHEN review LIKE '%freez%' OR review LIKE '%froze%' OR review LIKE '%restrict%'
             OR review LIKE '%block%' OR review LIKE '%suspend%' OR review LIKE '%lien%'
            THEN 'Account frozen or restricted'
        WHEN review LIKE '%customer care%' OR review LIKE '%customer service%'
             OR review LIKE '%support%' OR review LIKE '%no response%' OR review LIKE '%respond%'
             OR review LIKE '%poor service%' OR review LIKE '%bad service%'
             OR review LIKE '%complaint%' OR review LIKE '%resolved%' OR review LIKE '%live chat%'
             OR review LIKE '%quick answer%' OR review LIKE '%stranded%'
            THEN 'Customer support'
        WHEN review LIKE '%loan%' OR review LIKE '%borrow%'
            THEN 'Loans'
        WHEN review LIKE '% ads%' OR review LIKE '%advert%' OR review LIKE '%betting%'
             OR review LIKE '%gambl%' OR review LIKE '%gaming%'
            THEN 'Ads, betting and gambling content'
        WHEN review LIKE '%scam%' OR review LIKE '%fraud%' OR review LIKE '%thief%'
             OR review LIKE '%steal%' OR review LIKE '%stole%' OR review LIKE '%hack%'
             OR review LIKE '%not secure%' OR review LIKE '%protection%'
            THEN 'Fraud, scam or security wording'
        WHEN review LIKE '%cvv%' OR review LIKE '%card%'
            THEN 'Card issues'
        WHEN review LIKE '%network%' OR review LIKE '%update%' OR review LIKE '%upgrade%'
             OR review LIKE '%download%' OR review LIKE '%install%' OR review LIKE '%compatible%'
             OR review LIKE '%version%' OR review LIKE '%varsion%'
             OR review LIKE '%crash%' OR review LIKE '%login%' OR review LIKE '%log in%'
             OR review LIKE '%otp%' OR review LIKE '%ussd%' OR review LIKE '%slow%'
             OR review LIKE '%takes long%' OR review LIKE '%not working%' OR review LIKE '%malfunction%'
             OR review LIKE '%not showing%' OR review LIKE '%internet%'
             OR review LIKE '%no data%' OR review LIKE '%without data%' OR review LIKE '%have data%'
             OR review LIKE '%enough data%' OR review LIKE '%need data%' OR review LIKE '%using data%'
            THEN 'App or network problem'
        WHEN LEN(review) < 120
             AND (review LIKE '%good%' OR review LIKE '%gud%' OR review LIKE '%nice%' OR review LIKE '%love%'
                  OR review LIKE '%perfect%' OR review LIKE '%great%' OR review LIKE '%best%'
                  OR review LIKE '%excellent%' OR review LIKE '%amazing%' OR review LIKE '%fast%'
                  OR review LIKE '%reliable%' OR review LIKE '%easier%' OR review LIKE '%easy%'
                  OR review LIKE '%wonderful%' OR review LIKE '%fantastic%' OR review LIKE '%helpful%'
                  OR review LIKE '%appreciate%' OR review LIKE '%beyond banking%' OR review LIKE '%trusted%'
                  OR review LIKE '%seamless%')
            THEN 'Positive text (noise)'
        WHEN LEN(review) - LEN(REPLACE(review, ' ', '')) + 1 < 3
            THEN 'Too short or name (noise)'
        ELSE 'Other or unclear'
    END AS category
INTO opay_categorised
FROM opay_reviews;

SELECT category, COUNT(*) AS reviews
FROM opay_categorised
GROUP BY category
ORDER BY reviews DESC;