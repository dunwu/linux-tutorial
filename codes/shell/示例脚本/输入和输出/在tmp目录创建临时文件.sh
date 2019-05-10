#!/bin/bash

# creating a temp file in /tmp

tempfile=`mktemp -t tmp.XXXXXX`

echo "This is a test file" > $tempfile
echo "This is the second line of the test" >> $tempfile

echo ”The temp is locate at : $tempfile“
cat $tempfile
rm -f $tempfile
