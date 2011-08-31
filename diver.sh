#!/bin/bash

# Roger Steve Ruiz
# hi@rogeruiz.com
# 2011

# Diver 1.0
# A bash script that dives into any URL passed into it and excavates any
# image, CSS, & JS assets it can find referenced on the index page.

# store passed in variables
type=$1
dir=$2

# prompt for the URL from the user
echo -n "Please enter a URL [http://www.example.com] : "
read -a URL

# check $dir passed in
if [[ $dir != "" ]]; then
	cd $dir # let's change directories
fi

# check $type passed in
if [[ $type == "-js" ]]; then
	$type="js"
elif [[ $type == "-css" ]]; then
	$type="css"
elif [[ $type == "-jpg" ]]; then
	$type="jpe?g"
elif [[ $type == "-gif" ]]; then
	$type="gif"
elif [[ $type == "-png" ]]; then
	$type="png"
elif [[ $type == "" ]]; then
	# type was blank, excavate everything!
	$type="(js|css|gif|jpe?g|png)"
	
	# useful for grabbing everything
	# even grabs hrefs in anchors
	# $type="\w{2,4}"
fi

# search the URL given for $type files
# and store them inside of the ${stella} array
stella=(`curl -L $URL | grep -P -o '(?<=src|href).*\.$type'`)

# storage arrays
imgCheck=("gif" "jpg" "jpeg" "png")
hyperCheck=("html" "htm" "aspx" "php")
domainCheck=("com" "net" "org" "gov" "co" "uk" "nl" "jp" "es")
stackCheck=("css" "js")

# display the file paths & how many were found
for data in ${stella[@]}; do
	echo $data
done
echo -n "Diver has found "
echo -n ${#stella[@]}
echo " assets."

# prompt the user to continue
echo -n "Would you like to continue? [y/n] : "
read -a ans

if [[ $ans == "y" ]]; then

	# loop through each path inside of ${stella}
	for data in ${stella[@]}; do
		# check if data is an absolute path
		if [[ ${data:0:4} == "http" ]]; then
			data="$data"
		# check for folder traversal
		elif [[ ${data:0:2} == ".." ]]; then
			# let's find the path after those dots
			data=`grep -P -o '(?<=\.\.').*\. <<$data`
		fi

		# check if the path is missing a slash at the beginning
		if [[ ${data:0:1} != "/" ]]; then
			# let's add the slash
			data="$URL/$data"
		else # the URL and path check out so let's concatenate
			data="$URL$data"
		fi

		# let's build out the file name for these assets
		domain=`grep -P -o '(?<=//)\w+\.\w+(\.?\w+)?' <<<$data`
		name=`grep -P -o '(?<=/)[\w\d\.-]*\.$type' <<<$data`
		ext=`grep -P -o '(?<=\.)$type' <<<$name`
		
		curl $data --create-dirs -o $ext/$domain.name
		
	done
	
	echo "Diver has finished diving."
	# let's list the contents
	ls -al -G
	
	exit
	
else # the user didn't type 'y', so no diving today
	echo "Diver will dive another day..."
	exit
fi