docker -v &>/dev/null || {
  echo "Docker is required"
  echo "https://www.docker.com/get-started"
  exit 2
}

docker build -t mysql-cluster . || {
  echo "Error building mysql-cluster"
  echo "See logs"
}
