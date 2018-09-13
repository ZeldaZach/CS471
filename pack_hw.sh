#!/bin/bash
set -e

USAGE_STRING="$0 assignment_directory"

if [[ $# -ne 1 ]]; then
	echo "$0: Usage: $USAGE_STRING"
fi

ASSN_DIR="$1"
DATA_DIR=$ASSN_DIR

if [ ! -e "$ASSN_DIR" ]; then
	echo "$0: Can't find \"$ASSN_DIR\""
	exit 1
fi

DO_WRAP=0
if [ ! -d "$ASSN_DIR" ]; then
	echo "$0: \"$ASSN_DIR\" is a single file, not a directory."
	read -p "$0: Do you have any other files in your submission? (y/n) " yn
	while true; do
		case $yn in
			[Nn]* ) DO_WRAP=1;
				echo "$0: Will wrap file in directory before tar."
				break;;
			[Yy]* ) echo "$0: Pass the directory containing all of your files instead of \"$ASSN_DIR\"."
				exit 0;;
			* )	read -p "$0: Do you have any other files in your submission? (y/n) " yn;;
		esac
	done
fi

ASK_NUMBER=0
NUMBER=-1
FILE_REGEX=".*([0-9]+)((/?)|(\..+))"

if [[ "$ASSN_DIR" =~ $FILE_REGEX ]]; then
	NUMBER="${BASH_REMATCH[1]}"
	read -p "$0: Detected \"$NUMBER\". Is this homework $NUMBER? (y/n) " yn
	while true; do
		case $yn in
			[Nn]* ) ASK_NUMBER=1
				break;;
			[Yy]* ) break;;
			* )	read -p "$0: Is this homework $NUMBER? (y/n) " yn
		esac
	done
else
	ASK_NUMBER=1
fi

if [[ "$ASK_NUMBER" -eq 1 ]]; then
	read -p "$0: Which homework is this? " NUMBER
	while true; do
		case $NUMBER in
			[0-9]* ) break;;
			* )	read -p "$0: Please enter a number. Which homework is this? " NUMBER;;
		esac
	done
fi

USERNAME="`whoami`"
read -p "$0: Is \"$USERNAME\" your bmail username? (y/n) " yn
while true; do
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) read -p "$0: What is your bmail username? " USERNAME
			break;;
		* )	read -p "$0: Is \"$USERNAME\" your bmail username? (y/n) " yn
	esac
done

FILE_NAME="$USERNAME""_hw$NUMBER"

if [[ "$DO_WRAP" -eq 1 ]]; then
	if [ -e "$FILE_NAME" ]; then
		echo "$0: Can't create wrapper directory, \"$FILE_NAME\" already exists."
		exit 1
	fi
	DATA_DIR=$FILE_NAME

	mkdir "$DATA_DIR"
	#Note that ASSN_DIR was actually a single file.
	cp "$ASSN_DIR" "$DATA_DIR"
fi

if [ -e "$FILE_NAME.tar.gz" ]; then
	echo "$0: Can't create, \"$FILE_NAME.tar.gz\" already exists."
	exit 1
fi

tar -czvf "$FILE_NAME.tar.gz" "$DATA_DIR"

echo "$0: Created \"$FILE_NAME.tar.gz\". Please submit this file to myCourses."

#Clean up the temporary copy.
if [[ "$DO_WRAP" -eq 1 ]]; then
	rm -r "$FILE_NAME"
fi
