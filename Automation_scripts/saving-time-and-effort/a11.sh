#! /usr/bin/bash

downloads_directory="$HOME/Downloads"

if [ -z "$1" ]
then
        echo "ERROR: Download list file is not specified in the arguments" >&2;
        exit 1;
fi

if ! [ -z "$2" ]
then
        downoads_directory=$2
fi

if [ ! -d $downloads_directory ]
then
        mkdir -p $downoads_directory
fi

download_list=$1

cat $download_list | while read url
do
        echo "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _"
        echo "$url"
        wget -p $downloads_directory $url
done

exit 0
