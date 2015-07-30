#!/bin/sh

APP=""

DBNAME=""
DBUSER=""
DBPASS=""

DATE=$( date '+%Y%m%d-%H%M' )

DIR="/srv/users/serverpilot"
ORIGIN="$DIR/apps/$APP"
DESTINATION="$DIR/backups"
FILENAME="$APP-$DATE"

mkdir ${DESTINATION} > /dev/null 2>&1

echo "$(tput bold)$(tput setaf 4)==> $(tput setaf 7)Exporting database"
mysqldump --add-drop-table -u ${DBUSER} -p${DBPASS} ${DBNAME} > ${ORIGIN}/${FILENAME}-adt.sql
mysqldump --add-drop-database -B -u ${DBUSER} -p${DBPASS} ${DBNAME} > ${ORIGIN}/${FILENAME}-add.sql

echo "$(tput bold)$(tput setaf 4)==> $(tput setaf 7)Archiving"
tar czPf ${DESTINATION}/${FILENAME}.tgz --exclude="cache" ${ORIGIN}/shared ${ORIGIN}/${FILENAME}-*.sql 
rm ${ORIGIN}/${FILENAME}-*.sql

echo "$(tput bold)$(tput setaf 4)==> $(tput setaf 7)All done"
