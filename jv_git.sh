# Goal: push code changed by a single coder

# Arguments
COMMENT=`echo "$1" |  sed "s/ /_/g" ` 
NB_PARAMS=$#

# Input Values
NB_HOURS=3

# Calculated values
NB_SECONDS=` expr $NB_HOURS \* 3600 ` 

# Commands list
# CMD0="git config credential.helper 'cache --timeout=$NB_SECONDS'"
# CMD1="\"git add . \""
# CMD2="git commit -m '$COMMENT' "
# CMD3='git push '
# CMD_LIST="$CMD1 $CMD2 $CMD3"

CMD0="git_config_credential.helper_'cache_--timeout=$NB_SECONDS'"
CMD_LIST="	
	git_add_.  \
	git_commit_-m_'$COMMENT' \
	git_push \
	"

# SYNTAX
echo "INFO Syntax: $0 \"Comment for commit\" "

NB_CRED_LINES=`git config --list | grep credential.helper | wc -l`
if [ $NB_CRED_LINES -eq 0 ] 
	then
		CMD_LIST="	$CMD0 \
					$CMD_LIST"
	else
		echo "Credentials timeout is set in seconds: $NB_SECONDS "
fi

echo "INFO Commands to be executed:"
for CMDn in $CMD_LIST
	do
		echo "     $CMDn" | sed "s/_/ /g"
	done

# Parameters Check
if [ $NB_PARAMS -ne 1 ] 
	then 
		echo "ERROR: Check the number of arguments"
		exit 1 
fi

# Launch git add -> commit -> push 

for CMDn in $CMD_LIST
	do
		echo "==================================================="
		CMD=`echo "     $CMDn" | sed "s/_/ /g"`
		echo "$CMD"
		eval $CMD
		if [ $? -ne 0 ]
			then 
				echo "ERROR: Command interrupted"
				exit 1
			else
				echo "OK: Command Completed"
		fi
	done
