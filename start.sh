echo "Building"
sh ./build.sh || exit 2
echo "Starting"
sh cluster.sh || exit 2
echo "Done."
exit 0
