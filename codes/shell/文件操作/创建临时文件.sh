#!/usr/bin/env bash

tempFile=`mktemp test.XXXXXX`

exec 3> ${tempFile}

echo "This script writes to temp file ${tempFile}"
echo "This is the first line" >&3
echo "This is the second line" >&3
echo "This is the last line" >&3

exec 3>&-

echo "Done creating temp file. The contents are:"
cat ${tempFile}

rm -f ${tempFile} 2> /dev/null

