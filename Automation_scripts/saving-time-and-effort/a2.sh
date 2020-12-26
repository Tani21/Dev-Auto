#!/bin/bash

if [ -z "$1" ]; then
        echo "ERROR: no argument supplied" >&2; exit 1;
fi

archives_directory=$(realpath $1)

if [ ! -d "$archives_directory" ]; then
        echo "ERROR: Archives directory does not exist" >&2; exit 1;
fi

find $archives_directory -type f -name '*.txt' -mmin +$((2)) -exec rm {} \;

path_to_script=$(realpath "$0")

if ! (crontab -l | grep -Fxq "* * * * * $path_to_script $archives_directory")
then
        crontab -l | { cat; echo "* * * * * $path_to_script $archives_directory"; } | crontab - echo "Script added to cron"
fi

exit 0
