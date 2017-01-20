#!/bin/bash  

FILES=$(find ../ -name *.tga)
SAVEDSPACE=0
FILECOUNT=0

for i in $FILES; do
	IFS='.' read -a FILENAME <<< "$i"
	IFS='/' read -a SPLIT <<< ${FILENAME[2]}
	NEWFILE=${SPLIT[1]}
	NEWFILE+=".png"
	echo "NEWFILE" $NEWFILE "from" $i
	ORIGSIZE=$(stat --printf="%s" $i)
	convert $i -quality 2 -resize 50% $NEWFILE
	NEWSIZE=$(stat --printf="%s" $NEWFILE)
	SAVED=($ORIGSIZE - $NEWSIZE)
	echo "Saved:" $SAVED
	SAVEDSPACE+=$SAVED
	FILES=($FILES + 1)
done

echo "Total Saved Space: " $SAVEDSPACE "on" $FILECOUNT "files"
