# Goal: push code changed by a single coder

# Arguments
COMMENT=$1
NB_PARAMS=$#

# Input Values
NB_HOURS=3

# Calculated values
NB_SECONDS=` expr $NB_HOURS \* 3600 ` 

# Commands list
CMD0="git config credential.helper 'cache --timeout=$NB_SECONDS'"
CMD1="git add . "
CMD2="git commit -m \"$COMMENT\" "
CMD3="git push "

# SYNTAX
echo "INFO Syntax: $0 \"Comment for commit\" "
echo "INFO Commands to be executed:"
for CMDn in "$CMD0" "$CMD1" "$CMD2" "$CMD3"
	do
		echo "     $CMDn"
	done

# Parameters Check
if [ $NB_PARAMS -ne 1 ] 
	then 
		echo "ERROR: Check the number of arguments"
		exit 1 
fi

NB_CRED_LINES=`git config --list | grep credential.helper | wc -l`
if [ $NB_CRED_LINES -eq 0 ] 
	then
		echo $CMD0
		$CMD0
	else
		echo "Credentials timeout is set in seconds: $NB_SECONDS "
fi

# Launch git add -> commit -> push 
for CMDn in "$CMD1" "$CMD2" "$CMD3"
	do
		echo $CMDn
		$CMDn
		if [ $? -ne 0 ]
			then 
				echo "ERROR: Command interrupted"
				exit 1
		fi
	done
