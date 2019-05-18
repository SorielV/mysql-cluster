#!/bin/sh

docker -v &>/dev/null || {
  echo "Docker is required"
  echo "https://www.docker.com/get-started"
  exit 2
}

CONTAINERS_RUNNING=$(docker ps --format {{.Names}} | grep -E "(mgmd|ndbd1|ndbd2|mysql1|mysql2|mysql3)")
if [ ! -z "$CONTAINERS_RUNNING" ] 
then
  sh ./stop.sh
fi

CONTAINERS_NOT_RUNNING=$(docker ps -a --format {{.Names}} | grep -E "(mgmd|ndbd1|ndbd2|mysql1|mysql2|mysql3)")
if [ ! -z "$CONTAINERS_NOT_RUNNING" ]
then
  echo "Docker containers running"
  echo "Killing running containers"
  docker rm $CONTAINERS_NOT_RUNNING || {
    echo "Error stopping docker containers"
    exit 2
  }
  echo "Done"
else
  echo "Done"
fi

exit 0
