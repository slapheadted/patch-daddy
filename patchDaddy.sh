#!/bin/bash

# @title		Patch Daddy - "What's new eh?"
# @description	Parses unified diff format for new and deleted filenames
# @author		Chris Saunders


#
# Sets two global vars as a result
# pd_new_files (tf adds)
# pd_deleted_files (tf deletes)
function patchDaddy {
	if [ "$#" -ne 1 ]
	then
		echo "Usage: patchDaddy <diffFile.diff>"
		return
	fi

	# echo $line

	counter=0
	pd_new_files=()
	pd_deleted_files=()

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
				pd_new_files+=("${line:6}")
			elif [[ $mode == "deleted" ]]
			then
				pd_deleted_files+=("${line:6}")
			fi
		fi

		counter=$((counter + 1))
	done < $1
}