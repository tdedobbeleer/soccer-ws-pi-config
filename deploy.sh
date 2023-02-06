

#!/usr/bin/bash



usage() { echo "Usage: $0 [-e p|q] [-c start|stop|restart]" 1>&2; exit 1; }

stop() {
    sudo PORT=8080 ENV_PROFILE=${environment}  docker-compose -p ${DOCKER_NAME} down
}

restart() {
    stop
    start
}

start() {
    sudo PORT=8080 ENV_PROFILE=${environment} docker-compose -p ${DOCKER_NAME} up --build -d
}


while getopts e:c: flag
do
    case "${flag}" in
      e) environment=${OPTARG};;
      c) command=${OPTARG};;
      *) usage;;
    esac
done

if [ -z "${environment}" ] || [ -z "${command}" ]; then
    usage
fi

DOCKER_NAME=soccer-ws-multi

export $(grep -v deploy.env | xargs)

case "${command}" in
    "start") start;;
    "stop") stop;;
    "restart") restart ;;
    *) usage;;
esac
