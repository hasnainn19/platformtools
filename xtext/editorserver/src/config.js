

export const config = {

    port: process.env.ES_PORT || "10000",

    address: process.env.ES_ADDRESS || "http://127.0.0.1:" + process.env.ES_PORT || "10000",

    deployAddress: process.env.ES_DEPLOY_ADDRESS || "http://127.0.0.1:8074",

    deployFileLocation: process.env.ES_DEPLOY_FILE_LOCATION || "/usr/local/tomcat/webapps",

    endpointsPrefix: process.env.ES_ENDPOINT_PREFIX || "",

    trustedWebOrigins: ['http://127.0.0.1:8080'],


}