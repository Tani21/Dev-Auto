#! /usr/bin/bash

if [ -z "$1" ]
then
        echo "ERROR: Location of the web server's log is not specified" >&2; exit 1;
fi

log_file=$(realpath $1)
echo "path of log file is $log_file"
email_id=tanishkavaswani1@gmail.com

if [ ! -f "$log_file" ]
then
        echo "ERROE: Log file does not exist" >&2; exit 1;
fi

(
        echo -e 'Apache Web Server Access Logs - Summary\n'
        echo -e 'STATUS\t\t - \tCOUNT'
        cat $log_file | sed 's/.*HTTP\/1\.1" \(...\).*/\1/g' | sort | uniq -c | awk '{printf " %s\t\t-\t %s\n", $2, $1}'
        echo -e 'nIP ADDRESS\t - \tHITS'
        cat $log_file | sed 's/ .*//g'  | sort | uniq -c | awk '{printf "%s\t - \t %s\n", $2, $1}'
        ) > /tmp/log_summary

        echo "log summary"
        cat /tmp/log_summary

        cat /tmp/log_summary | mail -s "Apache web server access logs - Summary" $email_id

        if [[ $? != 0 ]]
        then
                echo "ERROR: error in sending mail to $(email)" >&2; exit 1;
        fi

        path_to_script=$(realpath "$0")
        if ! (crontab -l | grep -Fxq "0 * * * * $path_to_script $log_file")
        then
                crontab -l { cat; echo "0 * * * * $path_to_script $log_file"} |
                crontab - echo "Script added to cron"
        fi

exit 0
