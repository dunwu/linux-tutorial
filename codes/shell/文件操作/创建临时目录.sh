#!/usr/bin/env bash

tempDir=`mktemp -d dir.XXXXXX`
cd ${tempDir} || exit 1

tempFile1=`mktemp temp.XXXXXX`
tempFile2=`mktemp temp.XXXXXX`
exec 7> ${tempFile1}
exec 8> ${tempFile2}

echo "Sending data to directory $tempDir"
echo "This is a test line of data for $tempFile1" >&7
echo "This is a test line of data for $tempFile2" >&8

