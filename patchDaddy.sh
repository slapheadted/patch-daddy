#!/bin/bash

# @title		Patch Daddy - "What's new eh?"
# @description	Parses unified diff format for new and deleted filenames
# @author		Chris Saunders

echo "=============================="
echo "  Patch Daddy - sourced  			"
echo "=============================="

function patchDaddy {
	if [ "$#" -ne 1 ]
	then
		echo "Usage: patchDaddy <diffFile.diff>"
		return
	fi

	echo $line

	counter=0
	newFiles=()
	deletedFiles=()

	while read line
	do
		if [[ $line == *"new file mode"* ]]
		then
			counter=0
			mode="created"
		elif [[ $line == *"deleted file mode"* ]]
		then
			counter=1
			mode="deleted"
		fi

		if [[ $counter -eq 3 ]]
		then
			if [[ $mode == "created" ]]
			then
				newFiles+=("${line:4}")
			elif [[ $mode == "deleted" ]]
			then
				deletedFiles+=("${line:4}")
			fi
		fi

		counter=$((counter + 1))
	done < $1

	echo "newFiles: ${newFiles[@]}"
	echo "deletedFiles: ${deletedFiles[@]}"
}