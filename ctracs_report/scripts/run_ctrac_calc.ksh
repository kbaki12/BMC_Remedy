#!/usr/bin/ksh
#########################################################################
# run_ctrac_calc.ksh
# Khal Baki   01/20/2015
# Description:
# 1)Runs the CTRACS:Complaint Register Report. 
# emails it to email alias.
#
# 2) requires the Year parameter to be passed, example 2014.
#
#########################################################################
#Example: Connect to database using Net Service Name and the
#         database net service name is ORCL.
#
#         sqlplus myusername/mypassword@ORCL
#************************************************************************
# Modified  by:
# 03/06/2015 baki: Changed and implemented the new totaling system.
#
#########################################################################

                #**************************************************#
                #       Set Environment and start Logging.         #
                #**************************************************#
drive=`/bin/hostname |sed 's/is-zar//g'|sed 's/dr/prod/g'`
case "$drive" in
"prod")
   ORACLE_SID=PRODE
   ORACLE_HOME=/usr/local/oracle/product/11.2.0.2
   home=/usr/local/ar/ctracs_report
   arsystem="arsystem@gwl.com";;
"test")
   ORACLE_SID=DEVE
   ORACLE_HOME=/usr/local/oracle/product/11.2.0.2
   home=/usr/local/ar/ctracs_report
   arsystem="arsystem_dev@gwl.com";;
"dev")
   ORACLE_SID=DEVE
   ORACLE_HOME=/usr/local/oracle/product/11.2.0.2
   home=/usr/local/ar/ctracs_report
   arsystem="arsystem_dev@gwl.com";;
esac

runDate=`date +"%m%d%Y"`
runTime=`date +"%H%M%S"`

system=$1
company=$2
year=$3
user=$4

sqldir=$home/sql/activity
sqldir_alleg=$home/sql/allagation
logfile=$home/logs/ctrac_calc$year_$runDate.log
archlog=$home/logs/archive

report=$home/logs/ctrac_report.csv
file_name="ctrac_activity_report.csv"
resp_name="ctracs_response_report.csv"

act_macro=$home/sql/macro/CTRACSactivtyMacro.xlsm
actmacro_name="CTRACSactivtyMacro.xlsm"
resp_macro=$home/sql/macro/macroCTRACSResponse.xlsm
respmacro_name="macroCTRACSResponse.xlsm"

server=is-zar$drive
username=aradmin
key=`/usr/bin/cat /usr/local/ar/ref/pwd_enc_key.ref`
password=`/usr/local/ar/scripts/get_pwd p $key $ORACLE_SID $username`

#Export required environment.
#----------------------------
PATH=/usr/bin:/sbin:/usr/local/bin:$home/scripts:$ORACLE_HOME/bin
export PATH
export ORACLE_HOME
export ORACLE_SID

#Start logging the process.
#--------------------------
echo "ACode:AC03840" > $logfile
echo "Process started on: $runDate At:$runTime" >> $logfile
echo "****************************************************" >> $logfile

echo "Parameters Passed: $system $company $year $user ..." >> $logfile

echo "Inserting Calculated data in to TMP_CTRAC_CALCULATION table.." >> $logfile
echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/tmp_ctrac_calc_insert.sql $year >> $logfile

if [[ $system == 'activity' ]]
then
  echo "Run Type is $system." >> $logfile

  echo "Loading ctracs_activity_total_comp.sql" >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/ctracs_activity_total_comp.sql >> $logfile

  echo "Loading ctracs_activity_function.sql" >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/ctracs_activity_function.sql >> $logfile

  echo "Loading ctracs_activity_function_total.sql" >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/ctracs_activity_function_total.sql >> $logfile

  echo "Loading ctracs_activity_business.sql" >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/ctracs_activity_business.sql >> $logfile

  echo "Loading ctracs_activity_unit.sql" >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/ctracs_activity_unit.sql >> $logfile

  echo "Loading ctracs_activity_total.sql" >> $logfile
  count=5
  while [ $count -ne 0 ]
  do
    echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/ctracs_activity_total.sql $count >> $logfile
    count="$(($count - 1))"
  done

  echo "Generating CTRAC Activity Report." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir/tmp_ctrac_activ_report.sql $report >> $logfile

  echo "Sending report to email alias." >> $logfile
  (uuencode $report $file_name ; uuencode $act_macro $actmacro_name) | mailx -s"CTRAC Activity Report $year" $user 

  echo "Process Finished ..." >> $logfile
  mv $logfile $archlog
  rm $report
elif [[ $system == 'allegation' ]]
then
  echo "Run Type is $system." >> $logfile

  echo "Loading Line Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_1.sql >> $logfile 

  echo "Loading Line." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_2.sql >> $logfile 

  echo "Loading Line Total." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_3.sql >> $logfile 

  echo "Loading Allegation Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_4.sql >> $logfile 

  echo "Loading Allegation." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_5.sql >> $logfile

  echo "Loading Allegation Total." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_6.sql >> $logfile

  echo "Loading CTRACS Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_7.sql >> $logfile

  echo "Loading CTRACS Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_8.sql >> $logfile

  echo "Loading CTRACS Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_9.sql >> $logfile

  echo "Loading CTRACS Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_10.sql >> $logfile

  echo "Loading CTRACS Media." >> $logfile
  echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_11.sql >> $logfile

  echo "Loading ctracs_allegation_total.sql" >> $logfile
  count=11
  while [ $count -ne 0 ]
  do
    echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_total.sql $count >> $logfile
    count="$(($count - 1))"
  done

  echo "Setting up the passed Company value." >> $logfile

  if [[ $company == 'ALL' ]]
  then
    echo "Generating CTRAC Allegation Report ALL." >> $logfile
    echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_report_all.sql $report >> $logfile 
  else
    echo "Generating CTRAC Allegation Report." >> $logfile
    echo $password | sqlplus -s $username@$ORACLE_SID @$sqldir_alleg/ctracs_allegation_report.sql $report "$company" >> $logfile
  fi

  echo "Sending report to email alias." >> $logfile
  (uuencode $report $resp_name ; uuencode $resp_macro $respmacro_name) | mailx -s"CTRAC Response Report $year" $user
  #uuencode $report $file_name | mailx -s"CTRAC Response Report $year" $user

  echo "Process Finished ..." >> $logfile
  mv $logfile $archlog
  rm $report
else
  echo "Run Type is Invalid ... Stopping the process." >> $logfile
  mv $logfile $archlog
  exit 0
fi   

exit 0
