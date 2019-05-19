set PASSWORD=tacos
docker build -t mysql-cluster .
docker network create ncluster --subnet=10.10.10.0/16
echo "Starting manager [mgmd]"
docker run -d --net=ncluster --name=mgmd --ip=10.10.10.2 mysql-cluster ndb_mgmd
echo "Done"
echo "Starting ndbd [ndbd1, ndbd2]"
docker run -d --net=ncluster --name=ndbd1 --ip=10.10.10.3 mysql-cluster ndbd
docker run -d --net=ncluster --name=ndbd2 --ip=10.10.10.4 mysql-cluster ndbd
echo "Done"
echo "Staring mysql [mysql1, mysql2, mysql3]"
docker run -d --net=ncluster --name=mysql1 --ip=10.10.10.10 -e MYSQL_ROOT_PASSWORD=%PASSWORD% mysql-cluster mysqld
docker run -d --net=ncluster --name=mysql2 --ip=10.10.10.11 -e MYSQL_ROOT_PASSWORD=%PASSWORD% mysql-cluster mysqld
echo "Password: %PASSWORD%"
echo "Done"
echo "The MySQL nodes may take several minutes to state up"
docker run -it --net=ncluster mysql-cluster ndb_mgm