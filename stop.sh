#!/bin/bash
set -e
echo "Stopping "

cd "$( dirname "${BASH_SOURCE[0]}" )"
docker-compose stop
