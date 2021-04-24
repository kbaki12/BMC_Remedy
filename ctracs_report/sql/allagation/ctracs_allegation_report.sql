rem     **************************************************************
rem     * ctracs_allagation_report.sql 
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
COMPANY,
Report,
LINE,
MEDIA,
ALLEGATION,
Segment,
Business_Unit,
Q1_RESPONSES,
Q1_INTERNAL_ERROR,
Q1_PARTIAL_ERROR,
Q1_UNFOUNDED,
Q2_RESPONSES,
Q2_INTERNAL_ERROR,
Q2_PARTIAL_ERROR,
Q2_UNFOUNDED,
Q3_RESPONSES,
Q3_INTERNAL_ERROR,
Q3_PARTIAL_ERROR,
Q3_UNFOUNDED,
Q4_RESPONSES,
Q4_INTERNAL_ERROR,
Q4_PARTIAL_ERROR,
Q4_UNFOUNDED,
Q1_YTD,
Q1_YTD_PRIOR,
Q2_YTD,
Q2_YTD_PRIOR,
Q3_YTD,
Q3_YTD_PRIOR,
Q4_YTD,
Q4_YTD_PRIOR
From TMP_CTRAC_ALLEGATION
Where COMPANY = '&2'
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
