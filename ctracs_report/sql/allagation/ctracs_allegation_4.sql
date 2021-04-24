Insert INTO TMP_CTRAC_ALLEGATION
(
SELECT
RPTY AS Year,
'Total Media' AS Media,
'Total' AS Line,
'Total Product' AS Product,
Sum(ResponseQ1) AS Q1_Responses,
Sum(JustifiedQ1) AS Q1_Internal_Error,
Sum(JustifiedPartialQ1) AS Q1_Partial_Error,
Sum(JustifiedNoQ1) AS Q1_Unfounded,
Sum(ResponseQ2) AS Q2_Responses,
Sum(JustifiedQ2) AS Q2_Internal_Error,
Sum(JustifiedPartialQ2) AS Q2_Partial_Error,
Sum(JustifiedNoQ2) AS Q2_Unfounded,
Sum(ResponseQ3) AS Q3_Responses,
Sum(JustifiedQ3) AS Q3_Internal_Error,
Sum(JustifiedPartialQ3) AS Q3_Partial_Error,
Sum(JustifiedNoQ3) AS Q3_Unfounded,
Sum(ResponseQ4) AS Q4_Responses,
Sum(JustifiedQ4) AS Q4_Internal_Error,
Sum(JustifiedPartialQ4) AS Q4_Partial_Error,
Sum(JustifiedNoQ4) AS Q4_Unfounded,
Sum(ResponseQ1) AS Q1_ytd,
Sum(ResponseQ1P) AS Q1_ytd_Prior,
Sum(ResponseQ1+ResponseQ2) AS Q2_ytd,
Sum(ResponseQ1P+ResponseQ2P) AS Q2_ytd_Prior,
Sum(ResponseQ1+ResponseQ2+ResponseQ3) AS Q3_ytd,
Sum(ResponseQ1P+ResponseQ2P+ResponseQ3P) AS Q3_ytd_Prior,
Sum(ResponseQ1+ResponseQ2+ResponseQ3+ResponseQ4) AS Q4_ytd,
Sum(ResponseQ1P+ResponseQ2P+ResponseQ3P+ResponseQ4P) AS Q4_ytd_Prior,
COMPANY,
'Total Business' AS Business_Unit,
Segment,
'4' AS Report
FROM
TMP_CTRAC_CALCULATION
Where
((ResponseQ1P+ResponseQ2P+ResponseQ3P+ResponseQ4P)>0) OR ((ResponseQ1+ResponseQ2+ResponseQ3+ResponseQ4)>0)
GROUP BY
RPTY,
COMPANY,
'Total Media',
'Total',
'Total Product',
'Total Business',
Segment,
'4'
)
/
commit
/
