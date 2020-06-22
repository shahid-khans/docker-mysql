#!/bin/bash

set -e
cd "$( dirname "${BASH_SOURCE[0]}" )"

if [ ! -f .env ]; then
  echo "Having .env is required. Maybe you forgot to copy env-example?"
  exit 1
fi

while read -r line; do
  VARNAME=$(echo ${line} | awk '{sub(/\=.*/,x)}1')

  if [[ -z ${!VARNAME} ]]; then
    declare -x ${line}
  fi
done < <(egrep -v "(^#|^\s|^$)" .env)
echo "connecting as root user"
docker-compose exec mariadb mysql --user=root --password=${MARIADB_ROOT_PASSWORD} --database=${MARIADB_DATABASE} --port=${MARIADB_PORT}
