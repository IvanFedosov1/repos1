#!/bin/bash
BACKUPDIR=/home/user1/backup-catalog/ #каталог с файлами для архивирования
LOG=/home/user1/journal.txt #журнал
if [ ! -e $LOG ]; #Если файла журнала не существует, создаём
then 
	touch $LOG
fi

DIR="$(ls $BACKUPDIR)"
for catalog in $DIR; do
	ext=${catalog##*.} #Получаем расширение файла
	if [ $ext != "tgz" ]; #Если не архив
	then 
		if [ -e ${BACKUPDIR}${catalog}.tgz ]; #Если обычный файл проверяем есть ли уже его архив
		then 
		  lastmodifyfile=$(grep "^${catalog}:" $LOG)
		  lastmodifyfile=${lastmodifyfile##*:} #Получаем дату последнего изменения
		  currentmodifydate=$(stat -c%Z ${BACKUPDIR}${catalog}) #Получаем текущую дату изменения
		  if [ "$lastmodifyfile" == "$currentmodifydate" ] # Если даты совпадают, ничего не делаем
		  then true;
		  else #иначе архивируем изменённые файлы
	            tar -zcf $BACKUPDIR$catalog.tgz $BACKUPDIR 
		  fi
		  else	# Если архив не существует, то создаём его
	    	    tar -zcf $BACKUPDIR$catalog.tgz $BACKUPDIR 
		fi
		echo "${catalog}:$(stat -c%Z ${BACKUPDIR}${catalog})" >> $LOG # выводим дату в журнал
	fi
done
echo "---------------------------------" >> $LOG 
