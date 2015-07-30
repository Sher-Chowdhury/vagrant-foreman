#!/bin/bash
#########################################################################
# Created: Barry Goodall
# Date: July 2015
# Usage: To reset the usergroups and setup some default users for Foreman
#########################################################################


#########################################################################
#########################################################################
#
#  Safty check 
#
#########################################################################
#########################################################################

read -p "Are you sure you want to rest the users and groups? [y-n] " -n 1 -r
echo # (optional to move to a new line)
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	echo "Script halting with no changes"
	exit 1
fi

#########################################################################
#########################################################################
#
#  Deletes any existing user-groups 
#  Extracts the ID number from the list into lines  
#
#########################################################################
#########################################################################

# Pulls out the ID number from the group list
# grep "^[0-9]" only selects lines starting with a number.
# awk '{print $1;} selects the first col that is just the ID number
# For each of the ID numbers in the var line run the hammer user-group delete -id command
usergroups="$(hammer user-group list |grep "^[0-9]" | awk '{print $1;}')"
for group in $usergroups; do
	 hammer user-group delete --id $group
done

#########################################################################
#########################################################################
#
#  Deletes any existing user-groups 
#  Extracts the ID number from the list into lines  
#
#########################################################################
#########################################################################

# Pulls out the ID number from the user list but excludes the admin user
# grep "^[0-9]" only selects lines starting with a number.
# awk '{print $1;} selects the first col that is just the ID number
# For each of the ID numbers in the var line run the hammer user delete -id command
users="$(hammer user list |grep "^[0-9]" | grep -Ev 'Admin' | awk '{print $1;}')"
for userid in $users; do
	 hammer user delete --id $userid
done

#########################################################################
#########################################################################
#
#  Creates users for testing  
#
#########################################################################
#########################################################################

hammer user create --firstname Barry --lastname reader --password password --login reader  --mail reader@local --auth-source-id 1
hammer user create --firstname Barry --lastname devops --password password --login devops  --mail devops@local --auth-source-id 1
hammer user create --firstname Barry --lastname user --password password --login user  --mail user@local --auth-source-id 1
hammer user create --firstname Barry --lastname administrator --password password --login administrator  --mail administrator@local --auth-source-id 1


#########################################################################
#########################################################################
#
#  Creates user-groups, assigns roles to the groupd and adds 
#  users to group  
#
#########################################################################
#########################################################################

hammer user-group create  --name "Administrator" --role-ids 1,2,4,6,9,10 --users administrator
hammer user-group create  --name "DevOps Lead" --role-ids 2,4,6,9,10 --users devops
hammer user-group create  --name "DevOps User" --role-ids 3,5,7,11  --users user
hammer user-group create  --name "Read Only" --role-ids 5 --users reader

#########################################################################
#########################################################################
#
#  Prints out the user-group info
#    
#
#########################################################################
#########################################################################

#usergroupnew="$(hammer user-group list |grep "^[0-9]" | awk '{print $1;}')"
#for group in $usergroupnew; do
#	hammer user-group info --id $group
#	echo 'Press any key to continue'
#	read
#done
