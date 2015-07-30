#!/bin/bash
# Pulls out the ID number from the group list
# grep "^[0-9]" only selects lines starting with a number.
# awk '{print $1;} selects the first col that is just the ID number

lines="$(hammer user-group list |grep "^[0-9]" | awk '{print $1;}')"

# For each of the ID numbers in the var line run the hammer user-group delete -id command
for i in $lines; do
	 hammer user-group delete --id $i
done

lines="$(hammer user list |grep "^[0-9]" | grep -Ev 'Admin' | awk '{print $1;}')"
# For each of the ID numbers in the var line run the hammer role delete -id command
for i in $lines; do
	 hammer user delete --id $i
done

hammer user create --firstname Barry --lastname reader --password password --login reader  --mail reader@local --auth-source-id 1
hammer user create --firstname Barry --lastname devops --password password --login devops  --mail devops@local --auth-source-id 1
hammer user create --firstname Barry --lastname user --password password --login user  --mail user@local --auth-source-id 1
hammer user create --firstname Barry --lastname administrator --password password --login administrator  --mail administrator@local --auth-source-id 1

#hammer user-group add-user --name "Read Only" --user reader 
#hammer user-group add-user --name "DevOps User" --user user
#hammer user-group add-user --name "DevOps Lead" --user devops 
#hammer user-group add-user --name "Administrator" --user administrator 

hammer user-group create  --name "Administrator" --role-ids 1,2,4,6,9,10 --users administrator
hammer user-group create  --name "DevOps Lead" --role-ids 2,4,6,9,10 --users devops
hammer user-group create  --name "DevOps User" --role-ids 3,5,7,11  --users user
hammer user-group create  --name "Read Only" --role-ids 5 --users reader

lines="$(hammer user-group list |grep "^[0-9]" | awk '{print $1;}')"

# For each of the ID numbers in the var line run the hammer role delete -id command
for i in $lines; do
	 hammer user-group info --id $i
done

