complete -F _shell_cmd_complete jcd

function jcd {
	if [ "$1" == "" ]; then
		/path/to/jumpdir.sh -l
	else
		cd $(/path/to/jumpdir.sh -t $1)
	fi
}

