### Fork [mysql-cluster](https://github.com/mysql/mysql-docker/tree/mysql-cluster)
### Installation
[Install Docker](https://docs.docker.com/install/)

Linux :tada: :rocket:
```sh
git clone https://github.com/SorielV/mysql-cluster.git
cd mysql-cluster
./start.sh
```

Connection to mysql console
```
./mysql1.sh
docker exec -it mysql1 mysql -u root -p
```

Windows 
```cmd
git config --global core.autocrlf false
git clone https://github.com/SorielV/mysql-cluster.git
cd mysql-cluster
start.cmd
````
or
```cmd
git clone https://github.com/SorielV/mysql-cluster.git
cd mysql-cluster
git config core.autocrlf false
git rm --cached -r .
git reset --hard
start.cmd
```

Connection to mysql console
```
docker exec -it mysql1 mysql -u root -p
```

Docs
[Docker Mysql Cluster](https://hub.docker.com/r/mysql/mysql-cluster/)
[Mysql Cluster](https://dev.mysql.com/doc/mysql-cluster-excerpt/5.7/en/)
[Docker](https://docs.docker.com/)
