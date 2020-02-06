#!/bin/bash
# Backs up directory specified as the arguement
# Author: Varun Aggarwal
# Last Update: 02/06/20

echo

# few arguements 
if [ $# -lt 2 ]
then
    echo 'Specify source and destination of backup'
    echo 'Usage: ./my_backup.sh [Source folder]... [Destination Path]...'
    echo
    exit
fi

# extra arguements
if [ $# -gt 2 ]
then
    echo 'Too many arguements'
    echo 'Usage: ./my_backup.sh [Source folder]... [Destination Path]...'
    echo
    exit
fi

# Source directory doesn't exist
if [ ! -d $1 ]
then
    echo 'Source Directory does not exist'
    echo
    exit
fi

# Destination directory doesn't exist
if [ ! -d $2 ]
then
    echo 'Destination Directory does not exist, create new directory (y/n) ?'
    read response
    if [ $response = 'y' ]
    then
        mkdir $2
    else
        exit
    fi
fi

date=`date +%m-%d-%y`
sourceFolder=`basename $1`
parentSource=`dirname $1`

# Check Previous Backup
if [ -d $2/${sourceFolder}_${date} ]
then
    echo 'Overwrite backup for today? (y/n)'
    read answer
    if [ $answer != 'y' ]
    then
        echo
        exit
    fi
else
    mkdir $2/${sourceFolder}_${date}
fi

# copy folder
cp -R $parentSource/$sourceFolder/ $2/${sourceFolder}_${date}

echo 'Backup of' ${1} 'completed.'
echo 'Destination:' $2/${sourceFolder}_${date}
