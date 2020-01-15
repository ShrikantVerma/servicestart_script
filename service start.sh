vim filebeatstart.sh

#!/bin/sh
service=`systemctl status filebeat | sed -ne '3p' | cut -d ":" -f 2 | cut -d "(" -f 1`
status="active"
MESSAGE="filebeat is down"
MESSAGE2="filebeat is started"

if [ "$status" != "$service" ]
then
     echo "`date +'%x_%r'` :: $MESSAGE" >> /var/log/start.log
     echo "`date +'%d/%m/%y'` :: $MESSAGE" >> /var/log/start.log
    systemctl start filebeat
    sleep 5;
    echo "`date +'%x_%r'` :: $MESSAGE2" >> /var/log/start.log
else
   exit 0
fi