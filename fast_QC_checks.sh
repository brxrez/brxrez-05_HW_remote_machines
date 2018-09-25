# !/bin/bash 
# A script that condenses information about fasta files 
# and produces output. 

# Brian Rezende
# brezende@dons.usfca.edu
# September 21, 2018

# echo that this is a log file complied from fasta files
echo Generating log file from fasta files
echo 
# Display message indicating what will be presented and what the script is capable of
echo Output from preliminary quality control checks on selected fasta files 

echo
# echo the date and time of access
# Date command will display the date in time zone on which
# the unix/linux OS is configured 
date +"%Y-%m-%d %T"

echo  

# Detailing what output will include for each fasta file
echo Output for each fasta includes:
echo Filename, file size, first three lines, last three lines, 
echo the number of sequences in the file, and the
echo sequence identifier lines sorted alphabetically. 

echo 
echo "################################################################"

echo 

# Creating for loop for fasta file sequences
# It expects any number of fasta files as input

for file in "$@"
do
	FILENAME="$file"
	FILE_SIZE=$(du -h "$file" | cut -f 1)
	SEQUENCE_LIST=$(bioawk -c fastx '(length($seq) > 1) {print ">"$name}' "$file" | sort) 
	SEQUENCE_COUNT=$(bioawk -c fastx '(length($seq) > 1) {print ">"$name}' "$file" | wc -l)
	echo Output for "$FILENAME":
	echo
	echo Size: "$FILE_SIZE"
	echo
	echo First three lines: 
	echo -------------------------
	head -3 $file
	echo 
	echo Last three lines:
	echo -------------------------
	tail -3 $file
	echo 
	echo Number of sequences: "$SEQUENCE_COUNT"
	echo
	echo Sequence names:
	echo "$SEQUENCE_LIST"
done 

