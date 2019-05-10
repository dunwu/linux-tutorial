#!/bin/bash
#
# Record_Problem - records system problems in database
#
###########################################################
#
# Determine mysql location & put into variable
#
MYSQL=`which mysql`" Problem_Trek -u root"
#
###########################################################
#
# Create Record Id & Report_Date
#
#ID_NUMBER=`date +%y%m%d%H%M`
#
REPORT_DATE=`date +%y%m%d`
#
############################################################
#
# Acquire information to put into table
#
echo
echo -e "Birefly describe the problem & its symptoms: \c"
#
read ANSWER
PROB_SYMPTOMS=$ANSWER
#
# Set Fixed Date & Problem Solution to null for now
#
FIXED_DATE=0
PROB_SOLUTIONS=""
#
#############################################################
#
# Insert acquired information into table
#
echo 
echo "Problem recorded as follows:"
echo
id=$($MYSQL -e "INSERT INTO problem_logger VALUES (null,$REPORT_DATE,$FIXED_DATE,'$PROB_SYMPTOMS','$PROB_SOLUTIONS');SELECT LAST_INSERT_ID() id")
id=`echo $id | gawk '{print $2}'`
$MYSQL <<EOF
SELECT * FROM problem_logger where id_number=$id\G
EOF
#
#############################################################
#
# Check if want to enter a solution now
#
echo 
echo -e "Do you have a solution yet?(y/n) \c"
read ANSWER
#
case $ANSWER in
y|Y|YES|yes|Yes|yEs|yeS|YEs|yES)
	./Update_Problem.sh $id
#
;;
*)
# if answer is anything but yes, just exit script
;;
esac
#
############################################################
