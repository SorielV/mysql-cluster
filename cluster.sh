#!/bin/sh
declare PASSWORD
DEFAULT_PASSWORD="tacos"

docker -v &>/dev/null || {
  echo "Docker is required"
  echo "https://www.docker.com/get-started"
  exit 2
}

if [ -z "$1" ];
then
  PASSWORD=$DEFAULT_PASSWORD
else
  PASSWORD=$1
fi

if [ -z "`docker network ls | grep ncluster`" ] 
then
  echo "Creating network"
  docker network create ncluster --subnet=10.10.10.0/16 || exit 2
else
  docker inspect ncluster | grep '"Subnet": "10.10.10.0' &>/dev/null || {
    echo "ncluster shold have subnet 10.10.10.0"
    exit 2
  }
fi

CONTAINERS_RUNNING=$(docker ps --format {{.Names}} | grep -E "(mgmd|ndbd1|ndbd2|mysql1|mysql2|mysql3)")
if [ ! -z "$CONTAINERS_RUNNING" ]
then
  echo "Docker names are already used"
  echo $CONTAINERS_RUNNING
  echo "Run remove.sh"
  exit 2
fi

echo "Starting manager [mgmd]"
docker run -d --net=ncluster --name=mgmd --ip=10.10.10.2 mysql-cluster ndb_mgmd
echo "Done"
echo "Starting ndbd [ndbd1, ndbd2]"
docker run -d --net=ncluster --name=ndbd1 --ip=10.10.10.3 mysql-cluster ndbd
docker run -d --net=ncluster --name=ndbd2 --ip=10.10.10.4 mysql-cluster ndbd
echo "Done"
echo "Staring mysql [mysql1, mysql2, mysql3]"
docker run -d --net=ncluster --name=mysql1 --ip=10.10.10.10 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql-cluster mysqld
docker run -d --net=ncluster --name=mysql2 --ip=10.10.10.11 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql-cluster mysqld
docker run -d --net=ncluster --name=mysql3 --ip=10.10.10.12 -e MYSQL_ROOT_PASSWORD=$PASSWORD mysql-cluster mysqld
echo "Password: $PASSWORD"
echo "Done"
echo "The MySQL nodes may take several minutes to state up"
docker run -it --net=ncluster mysql-cluster ndb_mgm
exit 0
