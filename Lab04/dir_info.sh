#!/bin/bash
# Displays interesting directory facts
# Author: Varun Aggarwal
# Last Update: 02/06/20

echo

# extra arguements
if [ $# -gt 1 ]
then
    echo 'Too many arguements'
    echo 'Usage: ./dir_info.sh [Source folder]...'
    echo
    exit
fi

# default folder
if [ $# -lt 1 ]
then
    source='.'
else
	source=$1
fi

# Source directory doesn't exist
if [ ! -d $source ]
then
    echo 'Source Directory does not exist'
    echo
    exit
fi

# clear

# calculate details
numFiles=`ls -p $source | grep -v / | wc -w`
numFolders=`ls -p $source | grep / | wc -w`

hiddenFiles=$((`ls -ap $source | grep -v / | wc -w`-$numFiles))
hiddenFolders=$((`ls -ap $source | grep / | wc -w`-$numFolders-2))

largestFileName=`ls -lS $source | grep ^- | head -1 | awk '{ print $9 }'`
largestFileSize=`ls -lhS $source | grep ^- | head -1 | awk '{ print $5 }'`

mostRecentFile=`ls -lt $source | grep ^- | head -1 | awk '{ print $9 }'`
ownerList=`ls -l $source | awk '{ print $3 }' | sort -u`

# display details
echo 'Directory Details of' $source':'
echo
echo 'Total Files:' $numFiles
echo 'Total Folders:' $numFolders
echo 'Total Hidden Files:' $hiddenFiles
echo 'Total Hidden Folders:' $hiddenFolders
echo 'Largest File:' $largestFileName '[Size='$largestFileSize']'
echo 'Most Recent File:' $mostRecentFile
echo 'List of Users:'$ownerList
