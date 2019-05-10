#!/bin/bash
#
# Find_Problem - finds problem records using keywords
#
###########################################################
#
# Determine sql location & set variable
#
MYSQL=`which mysql`" Problem_Trek -u root"
#
##########################################################
#
# Obtain Keyword(s)
#
if [ -n "$1" ]      # Check if a keyword was passed
then				# Grab all the passed keywords
#
	KEYWORDS=$@		# Grab all the params as separate words, same string
#
else				# Keyword(s) not passed, Ask for them
	echo 
	echo "What keywords would you like to search for?"
	echo -e "Please separate words by a space: \c"
	read ANSWER
	KEYWORDS=$ANSWER
fi
#
#######################################################
#
# Find problem record
#
echo
echo "The following was found using keywords: $KEYWORDS"
echo
#
KEYWORDS=`echo $KEYWORDS | sed 's/ /|/g'`
#
$MYSQL <<EOF
SELECT * FROM problem_logger WHERE prob_symptoms REGEXP '($KEYWORDS)' OR prob_solutions REGEXP '($KEYWORDS)'\G
EOF
#
