#!/bin/bash
#########################################################################
# Created: Barry Goodall
# Date: July 2015
# Usage: To reset the usergroups and setup some default users for Foreman
#########################################################################


#########################################################################
#########################################################################
#
#  Safety check 
#
#########################################################################
#########################################################################

read -p "Are you sure you want to reset the users and groups on $HOSTNAME? [y-n] " -n 1 -r
echo # enter new line

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	echo "Script halting with no changes"
	exit 1
fi

read -p "Please enter the admin user for Foreman : " FMANID
echo  "Now enter the admin password for Foreman : " 
read -s FMANPWD

usercheck="$(hammer -u $FMANID -p $FMANPWD user list |grep "^[0-9]" | awk '{print $3;}')"

if [[ $usercheck = "" ]]; then
	echo "User not found"
	exit 1
fi

userlist="$(hammer -u $FMANID -p $FMANPWD user list |grep "^[0-9]"|grep -v "admin" | awk '{print $1;}')"

if [[ $userlist =~ '0-9*]+$' ]]; then
	echo "incorrect password"
	exit 1
fi
echo "Script now running"
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
# awk '{print $1;} selects the first col that is just the id
# For each of the ID numbers in the var line run the hammer user delete -id command

#userlist="$(hammer -u $FMANID -p $FMANPWD user list |grep "^[0-9]"|grep -v "admin" | awk '{print $1;}')"
for userid in $userlist; do
	 hammer -u $FMANID -p $FMANPWD user delete --name $id
done

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
usergroups="$(hammer -u $FMANID -p $FMANPWD user-group list |grep "^[0-9]" | awk '{print $1;}')"
for group in $usergroups; do
	 hammer -u $FMANID -p $FMANPWD user-group delete --id $group
done

#########################################################################
#########################################################################
#
#  Creates users for testing  
#
#########################################################################
#########################################################################

hammer -u $FMANID -p $FMANPWD user create \
	--firstname Barry \
	--lastname reader \
	--password password \
	--login reader \
	--mail reader@local \
	--auth-source-id 1
hammer -u $FMANID -p $FMANPWD user create \
	--firstname Barry \
	--lastname devops \
	--password password \
	--login devops \
	--mail 	devops@local \
	--auth-source-id 1
hammer -u $FMANID -p $FMANPWD user create \
	--firstname Barry \
	--lastname user \
	--password password \
	--login user \
	--mail user@local \
	--auth-source-id 1
hammer -u $FMANID -p $FMANPWD user create \
	--firstname Barry \
	--lastname administrator \
	--password password \
	--login administrator \
	--mail administrator@local \
	--auth-source-id 1

#########################################################################
#########################################################################
#
#  Creates user-groups, assigns roles to the groupd and adds 
#  users to group  
#
#########################################################################
#########################################################################

hammer -u $FMANID -p $FMANPWD user-group create  --name "Administrator" --role-ids 1,2,4,6,9,10 --users administrator
hammer -u $FMANID -p $FMANPWD user-group create  --name "DevOps Lead" --role-ids 2,4,6,9,10 --users devops
hammer -u $FMANID -p $FMANPWD user-group create  --name "DevOps User" --role-ids 3,5,7  --users user
hammer -u $FMANID -p $FMANPWD user-group create  --name "Read Only" --role-ids 5 --users reader

#########################################################################
#########################################################################
#
#  Prints out the user-group info
#    
#########################################################################
#########################################################################

#usergroupnew="$(hammer user-group list |grep "^[0-9]" | awk '{print $1;}')"
#for group in $usergroupnew; do
#	hammer user-group info --id $group
#	echo 'Press any key to continue'
#	read
#done

#########################################################################
#########################################################################
#
#  Change some settings
#
#########################################################################
#########################################################################

#hammer -u $FMANID -p $FMANPWD settings set --name send_welcome_email --value true
hammer -u $FMANID -p $FMANPWD settings set --name use_shortname_for_vms --value true
hammer -u $FMANID -p $FMANPWD settings set --name host_group_matchers_inheritance --value false
hammer -u $FMANID -p $FMANPWD settings set --name email_reply_address --value foreman-noreply@ordsvy.gov.uk


