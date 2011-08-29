#!/bin/bash

# Roger Steve Ruiz
# hi@rogeruiz.com
# 2011

# This is a simple script for downloading JavaScript files from a URL
# Currently this script can handle absolute paths, root relative paths,
# and relative paths. I haven't had much of a chance to test it extensively.
# any bug reports, or code critiques, are welcome.

# read in a URL
echo -n "Please enter a URL [http://www.example.com] : "
read -a URL

# search the main index file for javascript files
# and store them inside of an array
cssArr=(`curl -L $URL | grep -P -o '(?<=href=").*?css'`)

if [[ ${#cssArr[@]} == "0" ]]
then
	echo -n "There were "
	echo -n ${#cssArr[@]}
	echo " CSS files found."
	echo "Try again..."
	exit
fi

# display names & how many files were found
for css in ${cssArr[@]}
do
	echo $css
done
echo -n ${#cssArr[@]}
echo " files to be downloaded"

# prompt the user to continue
echo -n "Would you like to continue? [y/n] : "
read -a ANS

if [[ $ANS == "y" ]]
then
	# loop through each index in the array
	for css in ${cssArr[@]}
	do
		# check if css is an absolute path
		if [[ ${css:0:4} == "http" ]]
		then
			# the css path has a URL so we're good
			css="$css"
		# check if css contains a path that traverses up one folder
		elif [[ ${css:0:2} == ".." ]]
		then
			# let's find the path after those dots
			css=`grep -P -o '(?<=\.\.).*' <<<$css`
			# and remove them
			css="$URL$css"
		# check if css doesn't contains a slash in front
		elif [[ ${css:0:1} != "/" ]]
		then
			# let's add the slash
			css="$URL/$css"
		else
			# prepend the URL to the css path
			css="$URL$css"
		fi
		
		# grab the domain name and prepend it to the name of the file
		domain=`grep -P -o '(?<=//)\w+\.\w+(\.?\w+)?' <<<$css`
		
		# grab the just the name of the file currently on the server
		name=`grep -P -o '(?<=/)[\w\d\.-]*\.css' <<<$css`
		
		# echo "Saving $css as $domain.$name"
		curl $css -o $domain.$name
		
	done
else # the user didn't say 'y' to the question so let's quit
	echo "Exiting..."
	exit
fi