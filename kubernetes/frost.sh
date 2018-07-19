#!/usr/bin/env bash
#
# Start/Update/Stop a FROST-Server Kubernetes deployment
#
# @author Aurelien Bourdon

APP=$0

PROPERTIES_FILE=frost-properties.yml
ORDERED_TEMPLATE_FILES=(
    frost-secret.template.yml
    frost-db-local-volume.template.yml
    frost-db-local-volume-claim.template.yml
    frost-db-deployment.template.yml
    frost-db-service.template.yml
    frost-mqtt-deployment.template.yml
    frost-mqtt-service.template.yml
    frost-http-deployment.template.yml
    frost-http-service.template.yml
)

function start {
    for templateFile in ${ORDERED_TEMPLATE_FILES[@]}; do
        kubetpl render --syntax go-template --input $PROPERTIES_FILE $templateFile | kubectl apply -f -
    done
}

function stop {
    for templateFile in ${ORDERED_TEMPLATE_FILES[@]}; do
        kubetpl render --syntax go-template --input $PROPERTIES_FILE $templateFile | kubectl delete -f -
    done
}

function displayHelp {
    echo "usage: ${APP} [OPTIONS]"
    echo 'OPTIONS:'
    echo "      -s | --start            Start or update a FROST-Server Kubernetes deployment."
    echo "      -r | --stop             Stop (by deleting) FROST-Server Kubernetes deployment."
}

function parseOptionsAndRun {
    while [[ $# -gt 0 ]]; do
        local argument="$1"
        case $argument in
            -s|--start)
                start
                ;;
            -r|--stop)
                stop
                ;;
            -h|--help)
                displayHelp
                ;;
        esac
        shift
    done
}

function main {
    parseOptionsAndRun "$@"
}

main "$@"