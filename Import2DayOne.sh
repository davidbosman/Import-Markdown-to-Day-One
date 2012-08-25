#!/usr/bin/env bash

# http://davidbosman.fr || david@davidbosman.fr || août 2012.
# Feel free to modify and repost.
#
# This script is the second of two that will import a bunch of text files 
# formated in Markdown as Day One entries.
#
# In order to work, it requires Day One's CLI:
# http://dayoneapp.com/tools/
#
# It takes txt files in entry, with the name formated as:
# dont le nom commence par AAAA-MMJJ. 
#
# For each file, it'll create a new entry ion Day One, using the file name
# to set the date. 
# It'll use the time in the title to det the time.

for i in *
	do

# format entry time
time=`awk '/^##[#]?[ ]?[0-9][0-9]?[h:]/ {print $2}' "$i"`

# Check we have a number to defin time
if ! [[ "$time" =~ ^[0-9] ]]
	# If not a number
	then
	# We let Day One deal with the time
		TIMEFORMATED=""
	else
		# We got a time. We're so happy!
		# If time is a 3 digits+separator "h" ou ":": 9h10
		if [ "${time:1:1}" == "h" ] ||  [ "${time:1:1}" == ":" ]			
			then
			# we add a 0 before the first digit, to make it four.
			HOUR=0${time:0:1}
			MIN=${time:2:2}
		else
		# if it is a 4 digit time + separator "h" ou ":" : 09h27
			HOUR=${time:0:2}
			MIN=${time:3:2}
		fi
		# If minutes are not on 2 digits
		# Minutes are set to 00
		if ! [[ "$MIN" =~ ^[0-9][0-9]$ ]]
			then
				MIN="00"
		fi
		# Now we translate all that wonderful stuff in Day One Sprache "hh:mm"
		TIMEFORMATED=$HOUR:$MIN
fi

# Concatenate date and entry time in order to send it to Day One with the text
filename=$i
YEAR=${filename:0:4}
MONTH=${filename:5:2}
DAY=${filename:7:2}
ENTRYDATE=$MONTH/$DAY/$YEAR" "$TIMEFORMATED

# For each fil in the output folder, the new entry commande create 
# a... new entry (clever) at the date and time defined.
dayone -d="$ENTRYDATE" new < "$i"
done