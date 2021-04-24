rem     **************************************************************
rem     * tmp_ctrac_activ_report.sql 
rem     * Khal Baki
rem     * Date: 01/29/2015
rem     *-------------------------------------------------------------
rem     * Generates the CTRAC Activity Report. 
rem     *
rem     *-------------------------------------------------------------
rem     * Modified :
rem     *
rem     ***************************************************************

set termout off
set echo off
set verify off
set newpage none
set space 0
set pagesize 1000
set heading on
set feedback off
set trimspool on
set linesize 4000
set colsep ','
set underline off

spool &1

column REPORTED_COMPLAINT_FUNCTION heading "REPORTED_COMPLAINT_FUNCTION" Format a30

Select
YEAR,
'ALL' AS COMPANY,
REPORTED_COMPLAINT_FUNCTION,
ENDING_OPEN_PRIOR_Y,
RECEIVED_Q1,
RESPONSE_Q1,
JUSTIFIED_Q1,
JUSTIFIED_NO_Q1,
JUSTIFIED_PARTIAL_Q1,
CHANGE_Q1,
ENDING_OPEN_Q1,
RECEIVED_Q2,
RESPONSE_Q2,
JUSTIFIED_Q2,
JUSTIFIED_NO_Q2,
JUSTIFIED_PARTIAL_Q2,
CHANGE_Q2,
ENDING_OPEN_Q2,
RECEIVED_Q3,
RESPONSE_Q3,
JUSTIFIED_Q3,
JUSTIFIED_NO_Q3,
JUSTIFIED_PARTIAL_Q3,
CHANGE_Q3,
ENDING_OPEN_Q3,
RECEIVED_Q4,
RESPONSE_Q4,
JUSTIFIED_Q4,
JUSTIFIED_NO_Q4,
JUSTIFIED_PARTIAL_Q4,
CHANGE_Q4,
ENDING_OPEN_Q4
From 
TMP_CTRAC_COMPANY
Order By 
REPORTED_COMPLAINT_FUNCTION
/

spool off

spool &1 append
set heading off

column REPORTED_COMPLAINT_FUNCTION Format a30

Select * From TMP_CTRAC_FUNCTION
Order By COMPANY_, REPORTED_COMPLAINT_FUNCTION
/

spool off

spool &1 append
set heading off

column REPORTED_COMPLAINT_FUNCTION Format a30

Select * From TMP_CTRAC_TOTAL
Order By COMPANY_, REPORTED_COMPLAINT_FUNCTION
/

spool off
