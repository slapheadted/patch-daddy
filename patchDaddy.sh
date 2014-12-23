function patchDaddy {
	if [ "$#" -ne 1 ]
		echo "Usage: patchDaddy <diffFile.diff>"
		return
	echo $line

	counter=0
	newFiles=()
	deletedFiles=()

	while read line
	do
		if [[ $line == *"new file mode"* ]]
			counter=0
			mode="created"
		elif [[ $line == *"deleted file mode"* ]]
			counter=1
			mode="deleted"
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