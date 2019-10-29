#!/bin/ash

#set -vx

echo "Running tests..."

source /fedora-env.sh
apk -q --no-progress add curl
/init-fedora.sh 2>/run_tests.err 1>run_tests.out &

fedora_up 30

echo "** run_tests.err **"
cat /run_tests.err
echo "** run_tests.out **"
cat /run_tests.out

if [ $? -ne 0 ] ;
then
    echo "Exiting."
    exit 1;
fi