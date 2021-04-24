Delete From TMP_CTRAC_CALCULATION
/
commit
/
INSERT INTO TMP_CTRAC_CALCULATION
(
SELECT
&1 AS RPTY,
Complaint_Id,
decode(Status, 0, ' ', 1, 'Assigned', 2, 'Cancelled', 3, 'Closed'),
Company,
Reported_Complaint_Function,
(TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'MM/DD/YYYY')) AS Date_Received_by_Company,
CASE
WHEN (&1 = (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'YYYY')))
THEN 1
ELSE 0
END AS ReceivedY,
CASE
WHEN (&1 > (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'YYYY')))
THEN 1
ELSE 0
END AS ReceivedPriorY,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'Q') = 1) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ReceivedQ1,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'Q') = 2) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ReceivedQ2,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'Q') = 3) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ReceivedQ3,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'Q') = 4) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Date_Received_by_Company/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ReceivedQ4,
(TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'MM/DD/YYYY')) AS Response_Sent,
CASE
WHEN (&1 = (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')))
THEN 1
ELSE 0
END AS ResponseY,
CASE
WHEN (&1 > (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')))
THEN 1
ELSE 0
END AS ResponsePriorY,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 1) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ResponseQ1,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 2) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ResponseQ2 ,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 3) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ResponseQ3,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 4) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1
THEN 1
ELSE 0
END AS ResponseQ4,
CASE
WHEN (Complaint_Justified_ = 0 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 1)
THEN 1
ELSE 0
END AS JustifiedQ1,
CASE
WHEN (Complaint_Justified_ = 1 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 1)
THEN 1
ELSE 0
END AS JustifiedNoQ1,
CASE
WHEN (Complaint_Justified_ = 2 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 1)
THEN 1
ELSE 0
END AS JustifiedPartialQ1,
CASE
WHEN (Complaint_Justified_ = 0 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 2)
THEN 1
ELSE 0
END AS JustifiedQ2,
CASE
WHEN (Complaint_Justified_ = 1 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 2)
THEN 1
ELSE 0
END AS JustifiedNoQ2,
CASE
WHEN (Complaint_Justified_ = 2 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 2)
THEN 1
ELSE 0
END AS JustifiedPartialQ2,
CASE
WHEN (Complaint_Justified_ = 0 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 3)
THEN 1
ELSE 0
END AS JustifiedQ3,
CASE
WHEN (Complaint_Justified_ = 1 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 3)
THEN 1
ELSE 0
END AS JustifiedNoQ3,
CASE
WHEN (Complaint_Justified_ = 2 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 3)
THEN 1
ELSE 0
END AS JustifiedPartialQ3,
CASE
WHEN (Complaint_Justified_ = 0 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 4)
THEN 1
ELSE 0
END AS JustifiedQ4,
CASE
WHEN (Complaint_Justified_ = 1 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 4)
THEN 1
ELSE 0
END AS JustifiedNoQ4,
CASE
WHEN (Complaint_Justified_ = 2 And ((TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = &1) And TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 4)
THEN 1
ELSE 0
END AS JustifiedPartialQ4,
0,
0,
0,
0,
0,
0,
0,
0,
0,
CASE
WHEN ((&1 - 1) = (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')))
THEN 1
ELSE 0
END AS ResponseLastY,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 1) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = (&1 - 1)
THEN 1
ELSE 0
END AS ResponseQ1P,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 2) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = (&1 - 1)
THEN 1
ELSE 0
END AS ResponseQ2P,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 3) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = (&1 - 1)
THEN 1
ELSE 0
END AS ResponseQ3P,
CASE
WHEN (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'Q') = 4) And (TO_CHAR(TO_DATE('01/01/1970','MM/DD/YYYY')+(Response_Sent/( 60 * 60 * 24 )),'YYYY')) = (&1 - 1)
THEN 1
ELSE 0
END AS ResponseQ4P,
decode(Type_of_notification, 0, 'Written', 1, 'Verbal', 2, 'Social Media') AS Media,
Nature_of_Allegation AS Allegation,
CASE
WHEN (Business_Unit is null)
THEN Product_Services
ELSE Business_Unit || '" "' || Product_Services
END AS Product,
Business_Unit,
Segment
FROM
ctracs_complaint_register
WHERE
Status != 2
)
/
commit
/
