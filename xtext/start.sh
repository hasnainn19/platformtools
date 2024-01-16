#! /bin/bash

# clean any previous editor instances and builds
rm -rf ${ES_BUILD_LOCATION}/*
echo Old builds cleaned.

rm -rf ${ES_UPLOAD_LOCATION}/*
echo Old uploads cleaned.

find ${ES_DEPLOY_FILE_LOCATION}/ -type f -not -name 'ROOT.war' -delete
find ${ES_DEPLOY_FILE_LOCATION}/ -mindepth 1 -type d -not -name 'ROOT' -exec rm -rf {} \+ 
echo Old editor instances cleaned.

# setup cron job to periodically stop the server
if [ ! -z "${XTEXT_ES_STOP_CRON_TIME}" ]; then
    (crontab -l; echo "${XTEXT_ES_STOP_CRON_TIME}" echo Scheduled shutdown triggered. "&&" killall -u root) | crontab -
    crontab -l
    echo cron job for scheduled shutdown configured.
fi

# start tomcat
catalina.sh run &

# start toolfunction
(cd /toolservice/com.mde-network.ep.toolfunctions.xtextfunction; \
    mvn function:run \
    -Drun.functionTarget=com.mdenetnetwork.ep.toolfunctions.xtextfunction.RunXtextFunction \
    -Drun.port=$TS_PORT) &

# start editorserver
node ./src/server.js &

# start cron
cron

# wait for them all
wait -n