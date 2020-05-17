#!/bin/bash
set -e
echo "Starting "

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [ ! -f .env ]; then
  echo "Having .env is required. Maybe you forgot to copy env-example?"
  exit 1
fi

while read -r line; do
  VARNAME=$(echo ${line} | awk '{sub(/\=.*/,x)}1')
  echo $VARNAME

  if [[ -z ${!VARNAME} ]]; then
    declare -x "${line}"
  fi
done < <(egrep -v "(^#|^\s|^$)" .env)

docker-compose up -d ${DOCKER_SERVICES}
docker-compose logs -t -f ${DOCKER_LOG_AFTER_START}