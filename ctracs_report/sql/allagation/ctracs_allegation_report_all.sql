rem     **************************************************************
rem     * ctracs_allagation_report_all.sql 
rem     * Khal Baki
rem     * Date: 02/02/2015
rem     *-------------------------------------------------------------
rem     * Generates the CTRAC Allegation Report.
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

column COMPANY Format a8
column ALLEGATION heading "Product" Format a90
column LINE Format a15
column MEDIA Format a15
column Segment Format a20
column BUSINESS_UNIT Format a30

Select
YEAR,
'ALL' AS COMPANY,
Report,
LINE,
MEDIA,
ALLEGATION,
Segment,
Business_Unit,
SUM(Q1_RESPONSES) AS Q1_RESPONSES,
SUM(Q1_INTERNAL_ERROR) AS Q1_INTERNAL_ERROR,
SUM(Q1_PARTIAL_ERROR) AS Q1_PARTIAL_ERROR,
SUM(Q1_UNFOUNDED) AS Q1_UNFOUNDED,
SUM(Q2_RESPONSES) AS Q2_RESPONSES,
SUM(Q2_INTERNAL_ERROR) AS Q2_INTERNAL_ERROR,
SUM(Q2_PARTIAL_ERROR) AS Q2_PARTIAL_ERROR,
SUM(Q2_UNFOUNDED) AS Q2_UNFOUNDED,
SUM(Q3_RESPONSES) AS Q3_RESPONSES,
SUM(Q3_INTERNAL_ERROR) AS Q3_INTERNAL_ERROR,
SUM(Q3_PARTIAL_ERROR) AS Q3_PARTIAL_ERROR,
SUM(Q3_UNFOUNDED) AS Q3_UNFOUNDED,
SUM(Q4_RESPONSES) AS Q4_RESPONSES,
SUM(Q4_INTERNAL_ERROR) AS Q4_INTERNAL_ERROR,
SUM(Q4_PARTIAL_ERROR) AS Q4_PARTIAL_ERROR,
SUM(Q4_UNFOUNDED) AS Q4_UNFOUNDED,
SUM(Q1_YTD) AS Q1_YTD,
SUM(Q1_YTD_PRIOR) AS Q1_YTD_PRIOR,
SUM(Q2_YTD) AS Q2_YTD,
SUM(Q2_YTD_PRIOR) AS Q2_YTD_PRIOR,
SUM(Q3_YTD) AS Q3_YTD,
SUM(Q3_YTD_PRIOR) AS Q3_YTD_PRIOR,
SUM(Q4_YTD) AS Q4_YTD,
SUM(Q4_YTD_PRIOR) AS Q4_YTD_PRIOR
From TMP_CTRAC_ALLEGATION
Group By
YEAR,
'ALL',
Report,
LINE,
MEDIA,
ALLEGATION,
Segment,
Business_Unit
Order By 
YEAR,
Report,
COMPANY,
Line,
Media,
ALLEGATION,
SEGMENT,
BUSINESS_UNIT
/

spool off
