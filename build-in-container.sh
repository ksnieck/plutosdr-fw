#!/bin/bash
set -x

docker run --rm -it --name vivado-build -v $(dirname $(pwd)):/mnt vivado:2018.2 \
       /bin/bash --init-file /mnt/build.sh

