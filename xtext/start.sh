#! /bin/bash

if [ -n "${TRUSTED_ORIGINS}" ]; then
        sed -i "s|http://127.0.0.1:8080|${TRUSTED_ORIGINS}|g" ${ES_DEPLOY_FILE_LOCATION}/ROOT/WEB-INF/web.xml
        sed -i "s|http://127.0.0.1:8080|${TRUSTED_ORIGINS}|g" ../acemodebundler/web.xml
fi

# clean any previous editor instances and builds
rm -rf ${ES_BUILD_LOCATION}/*
echo Old builds cleaned.

rm -rf ${ES_UPLOAD_LOCATION}/*
echo Old uploads cleaned.

find ${ES_DEPLOY_FILE_LOCATION}/ -mindepth 1 -maxdepth 1 -type f -not -name 'ROOT.war' -delete
find ${ES_DEPLOY_FILE_LOCATION}/ -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} \+ 
echo Old editor instances cleaned.

# start tomcat
catalina.sh run &

# start toolfunction
(cd /toolservice/com.mde-network.ep.toolfunctions.xtextfunction; \
    mvn function:run \
    -Drun.functionTarget=com.mdenetnetwork.ep.toolfunctions.xtextfunction.RunXtextFunction \
    -Drun.port=$TS_PORT) &

# start editorserver
node ./src/server.js &

# start the websocket server
node ./src/websockets.js &

# start cron
cron

# wait for them all
wait -n
