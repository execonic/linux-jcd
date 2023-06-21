complete -F _shell_cmd_complete jcd

function jcd {
		cd $(path/to/jumpdir.sh -t $1)
}

