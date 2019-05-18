docker -v &>/dev/null || {
  echo "Docker is required"
  echo "https://www.docker.com/get-started"
  exit 2
}

docker run -it --net=ncluster mysql-cluster ndb_mgm -e "show"