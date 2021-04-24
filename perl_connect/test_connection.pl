#!/usr/bin/perl -w
#
# Khal Baki
# perl script to check connection to Oracle DB
# After connection do some queries to a table.
#
######################################################

push(@INC, "/home/baki/perl_lib");


use DBI;
require "prime_module.pm";

#use lib;

$dbh = &getOracleConnection(); 
if (!($dbh))
{
  die ("Failed to connect to database: " . DBI->errstr);
};

print "Connected Successfully to Oracle ..... \n";
print "Getting data from covid19_data table in Oracle ....\n"; 


$sql =
  "SELECT country, max(cumulative_deaths) ".
  "FROM covid19_data ".
  "where country = 'Lebanon'".
  "GROUP BY country";
if (!($sth = $dbh->prepare ($sql)))
{
  die ("Failed to prepare statement: " . DBI->errstr);
};

$sth->execute;

while (@data = $sth->fetchrow_array())
{
  $cont = $data[0];
  $death = $data[1];
#  print "Records: \n";
  printf "Results: Country is: $cont \t Total Death is: $death\n";
  #printf ("%3d%-20s \n",$cont,$death);
}

$sth->finish;

$dbh->disconnect;
