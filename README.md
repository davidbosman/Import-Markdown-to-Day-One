Split.sh is the first of two scripts that will import a bunch of text files 
formated in Markdown as Day One entries.

In order to work, each file name must start with AAAA-MMDD (wich will be as 
the date of the entries) and contain only one entry. So if, like me, you 
used to write a day worth of entries in a single file, like this:

2012-0816-J-my daily diary.txt:

	### 17H32
	Some text.
	
	### 23h41
	Some more text.
	![alt text](link to an image)
	
	Some more text.

	### some title but no time stamp
	Some text, again.

this script will look for occurences of ## or ### (or none, at the first 
line of the file) and, for each one consisting of a time stamp, will create 
a new file. (other ### will be added to the previous time stamp). 
So the example will look like this after spliting:

2012-0816-J-my daily diary1.txt:

	### 17H32
	Some text. 

2012-0816-J-my daily diary2.txt:

	### 23h41
	Some more text.
	
	![alt text](link to an image)
	
	Some more text.
	
	### some title but not a time stamp
	Some text, again.

Each new file will be created in a temporay export folder 
("~/Desktop/output"). This folder *must* exist before running the script.

The second script, Import2DayOne.sh, will deal with the import process 
itself, using Day One CLI.