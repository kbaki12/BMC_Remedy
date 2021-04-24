#!/usr/bin/ksh
#########################################################################
# ctrac_check.ksh 
# Khal Baki   01/29/2015
# Description:
# Checks to see if run_ctrac_calc.ksh is running before executing 
# ctrac_check.ksh.
#
# requires the Year parameter to be passed, example 2014.
#
#************************************************************************
# Modified  by:
#
#
#########################################################################

runDate=`date +"%m%d%Y"`
runTime=`date +"%H%M%S"`

home=/usr/local/ar/ctracs_report
logfile=$home/logs/ctrac_check$runDate$runTime.log
archlog=$home/logs/archive

system=$1
company=$2
year=$3
user=$4

#Start logging the process.
#--------------------------
echo "ACode:AC03840" > $logfile
echo "Process started on: $runDate At:$runTime" >> $logfile
echo "****************************************************" >> $logfile

if [[ -z $year ]]
then
  echo "You must pass the correct parameters to run this report"
  echo "Example: activity 2014 user"
  echo "You must pass the correct parameters to run this report" >> $logfile
  echo "Example: activity 2014 user" >> $logfile
  mv $logfile $archlog
  exit 0
fi

count=0
true=1
while [ $true ]
do
  pid=`/usr/bin/ps -ef | grep -w 'run_ctrac_calc.ksh' | egrep -v 'grep|view|vi|more|pg' | awk '{print $2}'`
  if [ $pid ]
  then
    if [ $count -gt 5 ]
    then
      echo "$user-Looks like the run_ctrac_calc.ksh is hung. acme has been notified." | mailx -s"appt_saptran problem" $user acme
      mv $logfile $archlog
      exit 0
    else
      echo "CTRAC Activity Process is running PID: $pid sleeping for 5."
      echo "CTRAC Activity Process is running PID: $pid sleeping for 5." >> $logfile
      count="$(($count + 1))"
      sleep 5
    fi
  else
    echo "CTRAC Activity Process is not running, Ok to continue ..." >> $logfile
    $home/scripts/run_ctrac_calc.ksh $system "$company" $year $user
    mv $logfile $archlog
    break
  fi
done

exit 0
