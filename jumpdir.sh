#!/bin/bash
# Author: siyuanliu
# E-mail: siyuanl96@gmail.com

ALIAS_DB="$(cd $(dirname ${BASH_SOURCE[0]}); pwd)/.jumpdir.db"

if [ ! -f "$ALIAS_DB" ]; then
		touch $ALIAS_DB
fi

Usage() {
		echo -e "	-a  Add or modify a alias."
		echo -e "	-t  Echo target directory."
		echo -e "	-l  List all aliases."
}

ParseOpts() {
		while getopts ":a:t:l" opt
		do
				case $opt in
				a)
						arr=(`echo $OPTARG | tr '=' ' '`)
						alias=${arr[0]}
						path=${arr[1]}

						SaveAlias $alias $path
				;;
				t)
						JumpTo $OPTARG
				;;
				l)
						ListAlias
				;;
				*)
						Usage
						exit 1
				;;
				esac
		done
}

ListAlias() {
		tmp=1
		cat $ALIAS_DB | while read line
		do
			if [ $tmp == 1 ]; then
				echo -e "\e[32;40m$line\E[0m"
				tmp=0
			else
				echo -e "\e[36;40m$line\E[0m"
				tmp=1
			fi
		done
}

SaveAlias() {
		path=$(SearchAlias $1)

		if [ "$path" != "" ]; then
				echo -e "The alias \e[32;40m$1=$path\E[0m already exist. Do you want to replace it? (y/n)"
				read continue
				if [[ "$continue" != "y" ]]; then
					exit 0
				fi

				sed -i '/^'$1'=/d' $ALIAS_DB
		fi

		echo "$1=$2" >> ${ALIAS_DB}
		sort ${ALIAS_DB} -o ${ALIAS_DB}
}

# return path
SearchAlias() {
		alias=$1
		path=`awk -F = '/^'$alias'=.+/ {print $2}' ${ALIAS_DB}`
		echo $path
}

JumpTo() {
		dst=$(SearchAlias $1)

		if [ "$dst" == "" ]; then
				echo "Alias does not exist."
				exit 1
		fi

		if [ ! -d $dst ] || [ "$dst" == "" ]; then
				echo -e "The directory \033[31m$dst\E[0m does not exist."
				exit 1
		fi

		echo $dst
}

if (( $# < 1 )); then
		Usage
		exit 1
fi

ParseOpts $@

