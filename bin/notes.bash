#!/bin/bash

dir=data/notes
#github="https://github.com/QuintenVervynck/duck.git"

red=$'\e[1;31m'
yel=$'\e[0;93m'
grn=$'\e[1;92m'
blu=$'\e[1;34m'
cya=$'\e[1;36m'
cyab=$'\e[1;96m'
end=$'\e[0m'

e="undefined"
d="undefined"
n="undefined"


########## printing functions ##########
printfile() {
	filename=$(echo $1 | egrep -o '[^/]+$')
	echo -e $cyab $filename $end
	while read line; do
		if [[ $line == -----* ]]; then
			echo $yel " " $line $end
		else
			echo "   >  "${line}
		fi
	done < $1
}
printer() {
	for file in $(ls -rt $dir); do
		# print the file
		printfile $dir/$file
	done
}

# unused, see example usage in -s option, but you need to specify a github repo above
save() {
	echo $cya"Saving changes..."$end
	ret=$(pwd | sed -E 's/(.*\/)[^/]+$/\1/')
	cd $dir
	git add . >> /dev/null
	git commit -m "`date`" >> /dev/null
	git push -q
	cd $ret
}

########## process ##########
while getopts ":he:d:n:s" opt; do
	case $opt in
		h  )	# help
			echo "duck [-edns [ arg ] ]"
			echo "  -e [regex] : edit todo-lists matching regex, edits all matched"
			echo "  -d [regex] : delete todo-lists matching regex, asks confirmation before delete"
			echo "  -n [name] : new todo-list with given name"
			echo "  -s : manual save"
			echo ""
			exit 0
			;;
		e  ) 	# optie -e (edit)
			e=$OPTARG
			file=$(find $dir -iname "*${e}*" )
			if [[ $file == "" ]];	then
				echo "Unknown todo-list" 1>&2
	         		exit 1
			fi
			nano $file
			printfile $file
			#save
			exit 0
         		;;
    		d  ) 	# optie -d (done/completed/delete)
         		d=$OPTARG
			for file in $(find $dir -iname "*${d}*"); do
				filename=$(echo $file | egrep -o '[^/]+$')
				read -p "Delete todo-list '${filename}'? y/n:  " check
				if [[ $check == "y" ]]; then
					echo "Todo-list "${filename}" is deleted"
					rm $file
				else
					echo "Todo-list "${filename}" was not deleted"
				fi
			done
			printer
			#save
			exit 0
        		;;
		n  ) 	# optie -n (new)
         		n=$OPTARG
			touch $dir/$n
			echo "-----info-----" >> $dir/$n
			echo "-----agenda-----" >> $dir/$n
			echo "-----todo-----" >> $dir/$n
			nano $dir/$n
			printfile $dir/$n
			#save
			exit 0
        		;;
        	s  )    # manual save
        		save
        		exit 0
        		;;
		: )	# optie zonder arg gegeven
			echo "Option requires argument" 1>&2
			exit 1
			;;
    		\? ) 	# invalid option
			echo "Unknown option '-$OPTARG'" 1>&2
         		exit 1
			;;
  		esac
	done
	shift $((OPTIND - 1))


########## printing all todo-lists ##########
if [[ $# -eq 0 ]]; then
	printer
	exit 0
fi


########## printing selected todo-lists ##########
if [[ $# > 1 ]]; then
	echo "I can only search todo-lists by one keyword" 1>&2
	exit 1
elif [[ $# -eq 1 ]]; then
	for file in $(find $dir -iname "*${1}*"); do
		printfile $file
	done
	exit 0
fi

