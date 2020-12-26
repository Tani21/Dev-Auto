#! /usr/bin/bash

if [ -z "$1" ]
then
        echo "ERROR: Device name is not specified in the arguments" >&2
        exit 1;
elif [ -z "$2" ]
then
        echo "ERROR: threshold is not specified in the arguments" >&2
        exit 1;
fi

device_name=$1
threshold_limit=$2
email_id=tanishkavaswani1@gmail.com

percentage_used=$(df -H | grep "${device_name}" | awk '{ print $5 }' | cut -d'%' -f1)

echo "Hostname is $(hostname)"
echo "Device name is ${device_name}"
echo "Percentage used is ${percentage_used}"
echo "Threshold limit is ${thresold_limit}"

if [ $percentage_used -ge $threshold_limit ]
then
        echo "Running out of space \"${device_name} (${percentage_used}%)\" on $(hostname) as on $(date)" |
                mail -s "Disk usage breached the threshold limit" $email_id
fi

path_to_script=$(realpath "$0")
if ! (crontab -l | grep -Fxq "*/1 * * * * $path_to_script $device_name $threshold_limit")
then
        crontab -l | { cat; echo "*/1 * * * * $path_to_script $device_name $threshold_limit"; } |
        crontab -
        echo "Script added to cron"
fi

exit 0
