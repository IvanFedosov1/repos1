#!/bin/bash
DIR=/home/dasha/backup/ 
LOG=/home/dasha/log.txt 
if [ ! -e $LOG ]; 
then 
	touch $LOG
fi

DIR="$(ls $DIR)"
for catalog in $DIR; do
ext=${catalog##*.} 
if [ $ext != "tgz" ]; 
then 
if [ -e ${DIR}${catalog}.tgz ]; 
then 
last=$(grep "^${catalog}:" $LOG)
last=${last##*:} 
current=$(stat -c%Z ${DIR}${catalog}) 
if [ "$last" == "$current" ] 
then true;
else 
tar -zcf $DIR$catalog.tgz $DIR 
fi
else	
tar -zcf $DIR$catalog.tgz $DIR 
fi
echo "${catalog}:$(stat -c%Z ${DIR}${catalog})" >> $LOG 
fi
done
echo "---------------------------------" >> $LOG 
