#!/bin/bash

# This is a simple script for downloading JavaScript files from a URL
# Currently this script can handle absolute paths, root relative paths,
# and relative paths. I haven't had much of a chance to test it extensively.
# any bug reporting, or code criticism, is welcome.

# read in a URL
echo -n "Please enter a URL [http://www.example.com] : "
read -a URL

# search the main index file for javascript files
# and store them inside of an array
jsArr=(`curl -L $URL | grep -P -o '(?<=src=").*js'`)

# display how many files were found
echo -n ${#jsArr[@]}
echo " files to be downloaded"

# prompt the user to continue
echo -n "Would you like to continue? [y/n] : "
read -a ANS

if [[ $ANS == "y" ]]
then
	for js in ${jsArr[@]}
	do
		# check if js is an absolute path
		if [[ ${js:0:4} == "http" ]]
		then
			js="$js"
		# check if js contains a path that traverses up one folder
		elif [[ ${js:0:2} == ".." ]]
		then
			js=`grep -P -o '(?<=\.\.).*' <<<$js`
			js="$URL$js"
		# check if js contains a slash in front
		elif [[ ${js:0:1} != "/" ]]
		then
			js="$URL/$js"
		else
			js="$URL$js"
		fi
		
		# grab the domain name and prepend it to the name of the file
		domain=`grep -P -o '(?<=//)\w+\.\w+(\.?\w+)?' <<<$js`
		
		# grab the name of the file currently on the server
		name=`grep -P -o '(?<=/)[\w\d\.-]*\.js' <<<$js`
		
		# echo "Saving $js as $domain.$name"
		curl $js -o $domain.$name
		
	done
else
	echo "Exiting..."
	exit
fi