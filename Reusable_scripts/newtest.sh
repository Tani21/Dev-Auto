#! /usr/bin/bash
. /home/tanishka/opt/lib/utils.sh

has_root_permission && echo "You are a root user" || echo "You are not a root user."

does_user_exit "ubuntu" && echo "User exists" || echo "User does not exist"

is_valid_file "/etc/passwd" && echo "Valid file" || echo "Invalid file"

die "this is an error message"
