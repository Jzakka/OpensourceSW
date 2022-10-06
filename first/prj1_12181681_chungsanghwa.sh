#! /bin/bash

filename=$1
echo '[Source code]'
cat $filename
echo '
--------------------
User Name: ChungSangHwa
Student Number: 12181681
[ MENU ]
1. Enable/disable empty line removal
2. Enable/disable comment removal
3. Enable/disable duplicate whitespaces among words
4. Add the line Number
5. Change the variable name
6. Remove ${} in arithmathic expansion
7. Export new filename
8. Exit
--------------------
'
prompt='Enter your choice [ 1-8 ]'

filecontent=$(cat "$filename")

function removeBlank(){
	read -p "Do you want to remove all blank line?(y/n):" rmblank

	if [ "$rmblank" = "y" ]
	then
	    filecontent=$(echo "$filecontent" | sed '/^\s*$/d')
	fi
}

function removeComment(){
	read -p "Do you want to remove all comment?(y/n):" rmcomment

	if [ "$rmcomment" = "y" ]
	then
	    filecontent=$(echo "#! /bin/bash";echo "$filecontent"| awk 'NR!=1{print $0}' | sed -Ee "s/^(([^#\"'\\]|'[^']*'|\"([^\"\\\\]|\\\\.)*\")*)#.*/\1/g")
	fi
}

function removeWhitespace(){
	read -p "Do you want to remove duplicate whitespaces?(y/n):" rmspace

	if [ "$rmspace" = "y" ]
	then
	    filecontent=$(echo "$filecontent" | sed -E 's/([^ ]+)\s+/\1 /g')
	fi
}

function addLineNumber(){
	read -p "Where you want to add whether the start or the end of the line. (s/e)" pos
	
	if [ "$pos" = "s" ]
	then
	    filecontent=$(echo "$filecontent" | awk '{printf("#%4d %s\n",NR,$0)}')
	elif [ "$pos" = "e"  ]
	then
	    filecontent=$(echo "$filecontent" | awk '{printf("%s #%d\n",$0,NR)}')
	fi  
}

function changVarName(){
	read -p "Variable name to be changed:" oldName
	read -p "New variable name:" newName

	filecontent=$(echo "$filecontent" | sed -E "s/${oldName}/${newName}/g")
}

function removeDoll(){
	read -p 'Do you want to remove ${}:(y/n)' rmdollar
	
	if [ "$rmdollar" = "y" ]
	then
	    filecontent=$(echo "$filecontent" | sed -E '/\$\(\([^\)]*\)\)/s/\$\{([^\}]*)\}/\1/g')
	fi
}

function exportFile(){
    	echo "$filecontent"
	echo "$filecontent" > "${filename}_modified_by_12181681_ChungSangHwa.sh"
}

read -p "$prompt" choice
until [ "$choice" = "8" ]
do
	case "$choice" in
	1)
		removeBlank;;
	2)
		removeComment;;
	3)
		removeWhitespace;;
	4)
		addLineNumber;;
	5)
		changVarName;;
	6)
		removeDoll;;
	7)
		exportFile;;
	*)
	esac
read -p "$prompt" choice
done
echo Bye!
