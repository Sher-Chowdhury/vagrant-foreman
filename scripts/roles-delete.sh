#!/bin/bash
# Pulls out the ID number from the roles list and excludes the default ones as these cannot be deleted
# grep "^[0-9]" only selects lines starting with a number.
# grep -Ev 'Default user|Anonymous' will then exlude the two defaults
# awk '{print $1;} selects the first col that is just the ID number
lines="$(hammer role list |grep "^[0-9]" | grep -Ev 'Default user|Anonymous' | awk '{print $1;}')"


# For each of the ID numbers in the var line run the hammer role delete -id command
for i in $lines; do
	 hammer role delete --id $i
done

