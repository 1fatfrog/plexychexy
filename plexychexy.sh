#!/bin/bash
#SNMP walk of Home media server and check service status for Plex Media Server
#Notify me via twillio text if Plex is offline
#This script assumes that you have service with twillio and have twillio-sms installed and configured to use twillio.conf file
#To to twillio.com for more information on their services

plexup="/home/[user]/plexup.time" 
plexdown='/home/[user]/plexdown.time'
myphone='/etc/twillio.conf ###-###-####' #Replace ###-###-#### with destination

while :; do if snmpwalk -Os -c public -v2c 127.0.0.1 iso.3.6.1.2.1.25.4.2.1.5 | grep [P]lex\ Media; then
	echo "PLEX is down!!!" | ./twillio-sms -c $mytwillio
	touch ~/plexdown.time 
	service plexmediaserver start
	rm $plexup $plexdown
	sleep 300
else
	sleep 300
fi
done

