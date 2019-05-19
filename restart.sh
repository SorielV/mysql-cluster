#!/bin/sh
docker -v &>/dev/null || {
  echo "Docker is required"
  echo "https://www.docker.com/get-started"
  exit 2
}

EXPECTED=5
COUNT_CLUSTER_CONTAINERS=$(docker ps -a --format {{.Names}} | grep -E "(mgmd|ndbd1|ndbd2|mysql1|mysql2)" | wc -l)

if [ "$COUNT_CLUSTER_CONTAINERS" -eq 0 ]
then
  echo "Docker containers are not added"
  echo "try exec cluster.sh"
  exit 2
elif [ "$EXPECTED" -ne "$COUNT_CLUSTER_CONTAINERS" ]
then
  echo "All docker containers are not added"
  echo "try exec remove.sh and cluster.sh"
  exit 2
else
  docker restart $(docker ps -a --format {{.Names}} | grep -E "(mgmd|ndbd1|ndbd2|mysql1|mysql2)")
  echo "Done"
  exit 0
fi
