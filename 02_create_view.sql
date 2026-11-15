CREATE   VIEW vw_opay_complaints AS  
SELECT  
    review_date,  
    DATEFROMPARTS(YEAR(review_date), MONTH(review_date), 1) AS month_start,  
    FORMAT(review_date, 'yyyy-MM') AS month_label,  
    rating,  
    review,  
    category,  
    CASE  
        WHEN category IN ('Positive text (noise)', 'Too short or name (noise)') THEN 'Noise'  
        WHEN category = 'Other or unclear' THEN 'Unclear'  
        ELSE 'Complaint'  
    END AS review_type  
FROM opay_categorised;