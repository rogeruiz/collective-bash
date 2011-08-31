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
jsArr=(`curl -L $URL | grep -P -o '(?<=src=").*\.js'`)

# display names & how many files were found
for js in ${jsArr[@]}
do
	echo $js
done
echo -n ${#jsArr[@]}
echo " files to be downloaded"

# prompt the user to continue
echo -n "Would you like to continue? [y/n] : "
read -a ANS

if [[ $ANS == "y" ]]
then
	# loop through each index in the array
	for js in ${jsArr[@]}
	do
		# check if js is an absolute path
		if [[ ${js:0:4} == "http" ]]
		then
			# the JS path has a URL so we're good
			js="$js"
		# check if js contains a path that traverses up one folder
		elif [[ ${js:0:2} == ".." ]]
		then
			# let's find the path after those dots
			js=`grep -P -o '(?<=\.\.).*' <<<$js`
			# and remove them
			js="$URL$js"
		# check if js doesn't contain a slash in front
		elif [[ ${js:0:1} != "/" ]]
		then
			# let's add the slash
			js="$URL/$js"
		else
			# prepend the URL to the JS path
			js="$URL$js"
		fi
		
		# grab the domain name and prepend it to the name of the file
		domain=`grep -P -o '(?<=//)\w+\.\w+(\.?\w+)?' <<<$js`
		
		# grab the just the name of the file currently on the server
		name=`grep -P -o '(?<=/)[\w\d\.-]*\.js' <<<$js`
		
		# echo "Saving $js as $domain.$name"
		curl $js -o $domain.$name
		
	done
else # the user didn't say 'y' to the question so let's quit
	echo "Exiting..."
	exit
fi