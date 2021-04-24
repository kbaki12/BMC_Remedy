insert into tmp_ctrac_report 
(
SELECT
RPTY AS Year,
'Total' AS Company_,
CASE
WHEN (REPORTED_COMPLAINT_FUNCTION is null) THEN '---'
ELSE REPORTED_COMPLAINT_FUNCTION
END AS REPORTED_COMPLAINT_FUNCTION,
Sum(OpenPriorY) AS Ending_Open_Prior_Y,
Sum(ReceivedQ1) AS Received_Q1,
Sum(ResponseQ1) AS Response_Q1,
Sum(JustifiedQ1) AS Justified_Q1,
Sum(JustifiedNoQ1) AS Justified_No_Q1,
Sum(JustifiedPartialQ1) AS Justified_Partial_Q1,
Sum(NetQ1) AS Change_Q1,
Sum(OpenQ1) AS Ending_Open_Q1,
Sum(ReceivedQ2) AS Received_Q2,
Sum(ResponseQ2) AS Response_Q2,
Sum(JustifiedQ2) AS Justified_Q2,
Sum(JustifiedNoQ2) AS Justified_No_Q2,
Sum(JustifiedPartialQ2) AS Justified_Partial_Q2,
Sum(NetQ2) AS Change_Q2,
Sum(OpenQ2) AS Ending_Open_Q2,
Sum(ReceivedQ3) AS Received_Q3,
Sum(ResponseQ3) AS Response_Q3,
Sum(JustifiedQ3) AS Justified_Q3,
Sum(JustifiedNoQ3) AS Justified_No_Q3,
Sum(JustifiedPartialQ3) AS Justified_Partial_Q3,
Sum(NetQ3) AS Change_Q3,
Sum(OpenQ3) AS Ending_Open_Q3,
Sum(ReceivedQ4) AS Received_Q4,
Sum(ResponseQ4) AS Response_Q4,
Sum(JustifiedQ4) AS Justified_Q4,
Sum(JustifiedNoQ4) AS Justified_No_Q4,
Sum(JustifiedPartialQ4) AS Justified_Partial_Q4,
Sum(NetQ4) AS Change_Q4,
Sum(OpenQ4) AS Ending_Open_Q4,
'Total Business' AS Business_Unit,
'Total Segment' AS Segment,
'3' AS Report
FROM
TMP_CTRAC_CALCULATION
GROUP BY
RPTY,
'Total',
REPORTED_COMPLAINT_FUNCTION,
'zTotal Business',
'zTotal Segment',
'3'
)
Order By 
COMPANY_, 
REPORTED_COMPLAINT_FUNCTION,
Business_Unit,
Segment
/
