delete from tmp_ctrac_report 
/
commit
/
insert into tmp_ctrac_report 
(
SELECT
RPTY AS Year,
CASE
WHEN (Company is null) THEN '---'
ELSE Company
END AS Company_,
'Total' AS Reported_Complaint_Function,
Sum(OPENPRIORY) AS Ending_Open_Prior_Y,
Sum(RECEIVEDQ1) AS Received_Q1,
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
Business_Unit,
Segment,
'1' AS Report
FROM
TMP_CTRAC_CALCULATION
GROUP BY
RPTY,
Company,
'Total',
Business_Unit,
Segment,
'1'
)
Order By 
COMPANY_ ,
Business_Unit,
Segment
/
