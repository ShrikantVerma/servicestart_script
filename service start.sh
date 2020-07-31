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



$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


HOSTNAME=`hostname -i`
NOW=$(date +"%Y-%m-%d")
DATETIME=$(date +"%d-%m-%Y-%H:%M:%S")
LOGFILE=/home/resolve/runningStatus.log
output=UP
/opt/enablegrafana/bin/status.sh | awk -F':' '{print $1}' > component.txt

cat component.txt | while read component
do
status=`/opt/grafana/bin/status.sh | grep $component | awk '{print $2}'`

        if [ "$output" == "$status" ]
 then
        pid=`/opt/grafana/bin/status.sh | grep $component |  awk '{print $4}'`
        #uptime=`ps -p $pid -o etimes | awk "NR==2"`
        uptime=`ps -p $pid -o etimes | awk 'NR==2{print $1}'`

                echo 'time:'$DATETIME' component_status:'$status' uptime:'$uptime' component:'$component' hostname:'$HOSTNAME'' >> $NOW.log
else
       if [ "$status" == "DOWN" ]; then

           echo 'time:'$DATETIME' component_status:'$status' uptime:0 component:'$component' hostname:'$HOSTNAME'' >> $NOW.log
        fi
fi
done
