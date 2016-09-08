#!/bin/bash
./launch_marathon.sh linpack_marathon.json
echo "Waiting 5 minutes for the first execution (0.5 CPU, 256M) to be completed"
./update_marathon.sh linpack_marathon.json 1 256
echo "Waiting 5 minutes for the second execution (1 CPU, 256M) to be completed"
./update_marathon.sh linpack_marathon.json 1 512
echo "Waiting 5 minutes for the third execution (1 CPU, 512M) to be completed"
./update_marathon.sh linpack_marathon.json 1 512
echo "Waiting 5 minutes for the fourth execution (1 CPU, 512M) to be completed"
./update_marathon.sh linpack_marathon.json 2 1024
echo "Waiting 5 minutes for the fourth execution (2 CPU, 1024M) to be completed"
./kill_marathon.sh linpack_marathon.json
echo "Framework killed"

